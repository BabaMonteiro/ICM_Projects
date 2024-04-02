import 'package:flutter/material.dart';

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
      backgroundColor: Colors.transparent, 
      elevation: 0,
      flexibleSpace: Container( 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF736CC6),
              Color(0xFF736CC6),
            ],
          ),
        ),
      ),
      leading: leadingIcon, 
      actions: actionIcons, 
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}