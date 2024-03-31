import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class SensorChallengeService {
  StreamSubscription? _userAccelerometerSubscription;
  final Function shakeDetected;
  final Function upsideDown;
  bool isUpsideDownDetected = false;
  Timer? _debounceTimer;

  SensorChallengeService({required this.shakeDetected, required this.upsideDown});

  void startListening() {
    _userAccelerometerSubscription = userAccelerometerEventStream().listen(_onUserAccelerometerEvent);
  }

  void stopListening() {
    _userAccelerometerSubscription?.cancel();
    _debounceTimer?.cancel();
  }

  void _onUserAccelerometerEvent(UserAccelerometerEvent event) {
    // Shake detection logic remains unchanged
    if (event.x.abs() > 12 || event.y.abs() > 12 || event.z.abs() > 12) {
      shakeDetected();
    }

    // Improved upside-down detection with a simple debounce mechanism
    if (event.z < -9.8 && !isUpsideDownDetected) {
      isUpsideDownDetected = true;
      upsideDown();
      _debounceTimer?.cancel(); // Cancel any existing timer
      _debounceTimer = Timer(Duration(seconds: 2), () {
      isUpsideDownDetected = false;
      });
    }
  }
}
