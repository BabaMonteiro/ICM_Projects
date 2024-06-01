import 'package:flutter/material.dart';

class Recents extends StatelessWidget {
  final List<String> covers = [
    'assets/images/madame_web.jpg',
    'assets/images/poor_things.jpg',
    'assets/images/the_holdovers.jpg',
    'assets/images/society_of_the_snow.jpg',
  ];

  Recents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5), // grey border
          //bottom: BorderSide(color: Colors.grey, width: 0.5), // thin grey border
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'RECENT ACTIVITY',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17.0,
                letterSpacing: 1,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: covers.map((cover) => Flexible( // flexible para ajustar ao ecrã
              child: Container(
                padding: const EdgeInsets.all(4.0), 
                child: Image.asset(
                  cover,
                  fit: BoxFit.fitHeight, 
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
