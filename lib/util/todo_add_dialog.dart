import 'package:flutter/material.dart';
import 'package:karma/util/todo_add_task_button.dart';

class TodoAddDialog extends StatelessWidget {
  final controller;
  final String title;
  VoidCallback onSaved;
  VoidCallback onCancel;

  TodoAddDialog({
    Key? key,
    required this.title,
    required this.controller,
    required this.onSaved,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[200],
      title: const Text('Add New Karma'),
      content: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              cursorColor: Colors.green,
              cursorWidth: 2.0,
              cursorRadius: const Radius.circular(8.0),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: Colors.lightGreen,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 2.0,
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.green,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                hintText: 'What is the Karma?',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TodoAddTaskButton(
                  name: 'Cancel',
                  onPressed: onCancel,
                ),
                const SizedBox(width: 8),
                TodoAddTaskButton(
                  name: "Save",
                  onPressed: onSaved,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
