
import 'package:flutter/material.dart';


class ProfilePicture extends StatelessWidget {

  ProfilePicture ({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Column(
          // profile picture
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            // add text undeer profile picture
            const Padding(
              padding: EdgeInsets.only(
                left: 8.0, top: 4, bottom: 3),
              child: Text(
                '@barbara2310',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  letterSpacing: 2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 8.0, top: 10, bottom: 13),
              child: Text(
                'Movie enthusiast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  letterSpacing: 2,
                ),
              ),
            ),
            
          ],
    );
  } // Add a closing curly brace here
}







