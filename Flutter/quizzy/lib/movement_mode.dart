import 'package:flutter/material.dart';
import 'package:quizzy/services/sensors.dart'; // Adjust the import path as necessary

class MovementMode extends StatefulWidget {
  @override
  _MovementModeState createState() => _MovementModeState();
}

class _MovementModeState extends State<MovementMode> {
  SensorChallengeService? sensorService;
  String currentTask = "Turn phone upside down";
  // Set the initial background color to the specified ARGB color
  Color backgroundColor = Color.fromARGB(255, 165, 131, 220); 
  bool isAwaitingReset = false; // Flag to indicate awaiting reset

  @override
  void initState() {
    super.initState();
    initializeSensorService();
  }

  void initializeSensorService() {
    sensorService = SensorChallengeService(
      shakeDetected: () {
        if (currentTask == "Shake phone 3 times" && !isAwaitingReset) {
          completeTask();
        }
      },
      upsideDown: () {
        if (currentTask == "Turn phone upside down" && !isAwaitingReset) {
          completeTask();
        }
      },
    );
    sensorService?.startListening(); 
  }

  void completeTask() {
    if (!isAwaitingReset) { 
      setState(() {
        // Change the background color temporarily to green on task completion
        backgroundColor = Colors.green; 
        isAwaitingReset = true; 
      });
      String nextTask = currentTask == "Turn phone upside down" ? "Shake phone 3 times" : "Turn phone upside down";
      Future.delayed(Duration(milliseconds: 500), () {
        resetTask(nextTask);
      });
    }
  }

  void resetTask(String nextTask) {
    setState(() {
      currentTask = nextTask; 
      // Reset the background color to the specified ARGB color after completion
      backgroundColor = Color.fromARGB(255, 165, 131, 220); 
      isAwaitingReset = false; 
    });
  }

  @override
  void dispose() {
    sensorService?.stopListening(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movement Mode'),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: backgroundColor, // This color changes based on task completion
        alignment: Alignment.center,
        child: Text(
          currentTask,
          // Increase the text size as requested
          style: TextStyle(color: Colors.black, fontSize: 30), 
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
