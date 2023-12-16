import 'package:flutter/material.dart';
import 'package:karma/util/todo_add_dialog.dart';
import 'package:karma/util/todo_add_task_button.dart';
import 'package:karma/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _editController = TextEditingController();

  final List todosList = [
    ['Task 1', false],
    ['Task 2', false],
    ['Task 3', false],
    ['Task 4', false],
    ['Task 5', false],
    ['Task 6', false],
  ];

  void toDoStateChanges(bool? value, int index) {
    setState(() {
      todosList[index][1] = value!;
    });
  }

  void createNewToDo() {
    showDialog(
      context: context,
      builder: (context) {
        return TodoAddDialog(
          title: 'Add New Karma',
          controller: _controller,
          onSaved: onSaved,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void onSaved() {
    setState(() {
      todosList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      todosList.removeAt(index);
    });
  }

  void onEdited(int index) {
    Navigator.of(context).pop();
    setState(() {
      todosList[index][0] = _editController.text;
    });
  }

  void editTask(int index, String? task) {
    _editController.text = task!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green[200],
          title: Text('Edit $task'),
          content: Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _editController,
                  autofocus: true,
                  cursorColor: Colors.green,
                  cursorWidth: 2.0,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TodoAddTaskButton(
                      name: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    TodoAddTaskButton(
                      name: "Save",
                      onPressed: () => onEdited(index),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KARMA'),
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todosList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todosList[index][0],
            isCompleted: todosList[index][1],
            onChanged: (newValue) {
              toDoStateChanges(newValue, index);
            },
            deleteTaskFunction: (context) => deleteTask(index),
            editTask: (context) => editTask(index, todosList[index][0]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewToDo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
