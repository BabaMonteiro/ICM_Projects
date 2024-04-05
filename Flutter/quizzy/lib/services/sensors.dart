import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class SensorChallengeService {
  StreamSubscription? _userAccelerometerSubscription;
  final Function shakeDetected;
  final Function upsideDown;
  bool isUpsideDownDetected = false;
  Timer? _debounceTimer;
  final Function onStillnessDetected;
  bool _isDeviceStill = false;
  DateTime? _stillnessStartTime;

  SensorChallengeService({required this.shakeDetected, required this.upsideDown,required this.onStillnessDetected });

  void startListening() {
    _userAccelerometerSubscription = accelerometerEventStream().listen(_onUserAccelerometerEvent);
  }

  void stopListening() {
  _userAccelerometerSubscription?.cancel();
  _debounceTimer?.cancel();
  _isDeviceStill = false; // Reset stillness detection
}

  int _shakeCount = 0;
  DateTime _lastShakeTimestamp = DateTime.now();

  void _onUserAccelerometerEvent(AccelerometerEvent event) {
     if (event.x.abs() > 14 || event.y.abs() > 14 || event.z.abs() > 14) { // Threshold for significant movement
      DateTime now = DateTime.now();
      if (now.difference(_lastShakeTimestamp) < Duration(seconds: 1)) { // Count shakes within 1 second
        _shakeCount++;
        if (_shakeCount >= 3) { // Considered a shake after 3 significant movements
          _shakeCount = 0; // Reset shake count
          shakeDetected();
        }
      } else {
        _shakeCount = 1; // Reset if more than 1 second passes between shakes
      }
      _lastShakeTimestamp = now;
    }

    const double upsideDownThreshold = -9.8; // Close to gravity's pull
    if (event.z < upsideDownThreshold) {
      if (!isUpsideDownDetected) {
        isUpsideDownDetected = true;
        upsideDown();
        // Use a debounce timer to prevent immediate re-triggering
        _debounceTimer?.cancel();
        _debounceTimer = Timer(Duration(seconds: 2), () {
          isUpsideDownDetected = false;
        });
      }
    }

    const double stillnessThreshold = 0.2; // Adjust based on testing
    if (event.x.abs() < stillnessThreshold && event.y.abs() < stillnessThreshold && (event.z > 9.8 - stillnessThreshold || event.z < -9.8 + stillnessThreshold)) {
        if (!_isDeviceStill) {
            _isDeviceStill = true;
            _stillnessStartTime = DateTime.now();
        } else if (_stillnessStartTime != null) {
            final durationStill = DateTime.now().difference(_stillnessStartTime!);
            if (durationStill.inSeconds >= 5) { // Adjust time based on requirement
                onStillnessDetected();
                _isDeviceStill = false; // Reset stillness detection
                _stillnessStartTime = null; // Reset the start time
            }
        }
    } else {
        _isDeviceStill = false; // Reset if the device moves
        _stillnessStartTime = null; // Also reset the start time here
    }
}
}
