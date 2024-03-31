import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class SensorChallengeService {
  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _userAccelerometerSubscription;
  final Function shakeDetected;
  final Function upsideDown;

  SensorChallengeService({required this.shakeDetected, required this.upsideDown});

  void startListening() {
    _accelerometerSubscription = userAccelerometerEvents.listen(_onUserAccelerometerEvent);
    _userAccelerometerSubscription = userAccelerometerEvents.listen(_onUserAccelerometerEvent);
  }

  void stopListening() {
    _accelerometerSubscription?.cancel();
    _userAccelerometerSubscription?.cancel();
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    // Implement shake detection logic here and call onShakeDetected when a shake is detected
  }

  void _onUserAccelerometerEvent(UserAccelerometerEvent event) {
    // Detect rapid movements for shake detection
    if (event.x.abs() > 12 || event.y.abs() > 12 || event.z.abs() > 12) {
      shakeDetected();
    }

    // Implement upside-down detection logic here and call onUpsideDownDetected when the condition is met
    if (event.z < -9.8) {
      upsideDown();
    }
  }
}
