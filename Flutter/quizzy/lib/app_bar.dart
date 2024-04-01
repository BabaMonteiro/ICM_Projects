import 'package:flutter/material.dart';
import 'package:quizzy/profile.dart';

class QuizzyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget? leadingIcon;
  final List<Widget>? actionIcons;

  const QuizzyAppBar({
    Key? key,
    required this.height,
    this.leadingIcon,
    this.actionIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Makes the AppBar's background transparent
      elevation: 0, // Removes shadow from the AppBar
      flexibleSpace: Container( // Use flexibleSpace to apply background gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF736CC6),
              Color(0xFF736CC6),
              // Add more colors for the gradient here if needed
            ],
          ),
        ),
      ),
      leading: leadingIcon, // Use the leadingIcon passed in
      actions: actionIcons, // Use the actionIcons passed in
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}