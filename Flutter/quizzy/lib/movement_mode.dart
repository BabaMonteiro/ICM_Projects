// create dummy MovementMode class

import 'package:flutter/material.dart';
import 'package:quizzy/services/sensors.dart';

// create dummy MovementMode widget
class MovementMode extends StatefulWidget {
  @override
  _MovementModeState createState() => _MovementModeState();
}

class _MovementModeState extends State<MovementMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movement Mode'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add code to start listening to sensor events
          },
          child: const Text('Start Listening'),
        ),
      ),
    );
  }
}