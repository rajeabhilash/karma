import 'package:flutter/material.dart';
import 'package:karma/db/database.dart';
import 'package:karma/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:karma/util/todo_add_dialog.dart';
import 'package:karma/util/todo_add_task_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _editController = TextEditingController();

  final mybox = Hive.box('karma');
  KarmaDatabase? db;

  @override
  void initState() {
    db = KarmaDatabase();
    super.initState();
  }

  void toDoStateChanges(bool? value, int index) {
    setState(() {
      db!.toDoList[index][1] = value!;
      db!.updateDataBase();
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
      db!.toDoList.add([_controller.text, false]);
      db!.updateDataBase();
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      db!.toDoList.removeAt(index);
      db!.updateDataBase();
    });
  }

  void onEdited(int index) {
    Navigator.of(context).pop();
    setState(() {
      db!.toDoList[index][0] = _editController.text;
      db!.updateDataBase();
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
        itemCount: db!.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db!.toDoList[index][0],
            isCompleted: db!.toDoList[index][1],
            onChanged: (newValue) {
              toDoStateChanges(newValue, index);
            },
            deleteTaskFunction: (context) => deleteTask(index),
            editTask: (context) => editTask(index, db!.toDoList[index][0]),
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
