import 'package:flutter/material.dart';

class ProfileList extends StatelessWidget {
  final List<Activity> activities = [
    Activity(text: 'Films', quantity: '393/39 this year'),
    Activity(text: 'Diary', quantity: '359/40 this year'),
    Activity(text: 'Reviews', quantity: '39'),
    Activity(text: 'Lists', quantity: '3'),
    Activity(text: 'Watchlist', quantity: '93'),
    Activity(text: 'Likes', quantity: '20'),
    Activity(text: 'Tags', quantity: '0'),
    Activity(text: 'Following', quantity: '16'),
    Activity(text: 'Followers', quantity: '15 ')
  ];

  ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: activities.length,
    itemBuilder: (context, index) {
      final activity = activities[index];
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5), // grey border
            bottom: BorderSide(color: Colors.grey, width: 0.5), // thin grey border
          ),
        ),
        child: ListTile(
          title: Text(
            activity.text,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,),
          ),
          trailing: Text(
            activity.quantity.toString(), 
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0,
              ), 
          ),
        ),
      );
    },
  );
}
}

class Activity {
  final String text;
  final String quantity;

  Activity({required this.text, required this.quantity});
}
