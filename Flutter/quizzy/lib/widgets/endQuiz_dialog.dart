import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EndQuizDialog {
  static void show(BuildContext context, VoidCallback onExitConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Game Ended!",
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 78, 13, 151)
              ,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onExitConfirmed();
              },
              icon: Icon(Icons.check, color: Colors.white), // Adjust icon as needed
              label: Text(
                "EXIT",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 78, 13, 151),
                side: BorderSide(color: Colors.white, width: 3),
                backgroundColor: Color.fromARGB(255, 70, 161, 86),
              ),
            ),
          ],
        );
      },
    );
  }
}
