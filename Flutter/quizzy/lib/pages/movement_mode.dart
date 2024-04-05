import 'package:flutter/material.dart';
import 'package:quizzy/services/sensors.dart'; // Adjust the import path as necessary
import 'package:quizzy/widgets/app_bar.dart';
import 'package:quizzy/widgets/exit_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/widgets/endQuiz_dialog.dart';

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
      onStillnessDetected: () {
      if (currentTask == "Keep phone still" && !isAwaitingReset) {
        completeTask();
      }
       },
    );
    sensorService?.startListening(); 
  }

  void completeTask() {
    if (!isAwaitingReset) { 
      setState(() {
        backgroundColor = Colors.green; 
        isAwaitingReset = true; 
      });
      //String nextTask = "";
      if (currentTask == "Keep phone still") {
      Future.delayed(Duration(milliseconds: 500), () {
        EndQuizDialog.show(context, () {
            Navigator.of(context).pop();
          });
      });
    } else {
      // Proceed with the next task
      String nextTask = "";
      if (currentTask == "Turn phone upside down") {
        nextTask = "Shake phone 3 times";
      } else if (currentTask == "Shake phone 3 times") {
        nextTask = "Keep phone still";
      }
      Future.delayed(Duration(milliseconds: 500), () {
        resetTask(nextTask);
      });
    }
  }
}

// void showCompletionDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Congratulations!"),
//         content: Text("You completed the 3 tasks."),
//         actions: <Widget>[
//           TextButton(
//             child: Text("Exit"),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               Navigator.of(context).pop(); // Assuming this exits to the previous screen
//             },
//           ),
//         ],
//       );
//     },
//   );
// }


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
    appBar: QuizzyAppBar(
      height: AppBar().preferredSize.height,
      leadingIcon: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () {
          ExitDialog.show(context, () {
            Navigator.of(context).pop();
          });
        },
      ),
    ),
    body: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: backgroundColor, 
      alignment: Alignment.center,
      child: Text(
        currentTask,
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
}
