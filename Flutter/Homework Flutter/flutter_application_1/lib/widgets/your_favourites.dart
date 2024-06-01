import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  final List<String> covers = [
    'assets/images/monster.jpg',
    'assets/images/mysterious_skin.jpg',
    'assets/images/past_lives.jpg',
    'assets/images/perfect_blue.jpg',
  ];

  Favourites({Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'FAVOURITES',
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
