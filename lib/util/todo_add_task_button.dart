import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoAddTaskButton extends StatelessWidget {
  final String name;
  VoidCallback onPressed;

  TodoAddTaskButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      padding: const EdgeInsets.all(16),
      onPressed: onPressed,
      child: Text(name),
    );
  }
}
