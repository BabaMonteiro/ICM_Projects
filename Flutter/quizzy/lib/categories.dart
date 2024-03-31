// quiz_options_dialog.dart
import 'package:flutter/material.dart';


class Categories extends StatelessWidget {
  const Categories({super.key, required this.startQuiz});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a category', style: TextStyle(fontSize: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('Geography'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('History'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('Art'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('Sports'),
          ),
        ],
      ),
      actions: [IconButton(onPressed: () => Navigator.of(context).pop, icon: const Icon(Icons.close))],
    );
  }
}
