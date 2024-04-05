import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitDialog {
  static void show(BuildContext context, VoidCallback onExitConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to exit?',
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 78, 13, 151),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        onExitConfirmed();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 78, 13, 151),
                        side: const BorderSide(color: Colors.white, width: 3),
                        backgroundColor: Color.fromARGB(255, 70, 161, 86),
                        
                      ),
                      icon: const Icon(Icons.check),
                      label: const Text('YES, I AM SURE!'),
                      
                    ),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 78, 13, 151),
                        side: const BorderSide(color: Colors.white, width: 3),
                        backgroundColor: Color.fromARGB(255, 201, 85, 70),
                      ),
                      icon: const Icon(Icons.close),
                      label: const Text('NO, I WANT TO STAY!'),
                    ),
                  ],
                )
              ],
            ),
          )
        );
      },
    );
  }
}
