import 'package:flutter/material.dart';
import './main.dart';

class AddView extends StatefulWidget {
  // view där nya tasks läggs till
  final String title;
  final AddTaskCallback addTaskCallback;

  const AddView(
      {super.key, required this.title, required this.addTaskCallback});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final TextEditingController _taskController =
      TextEditingController(); // används för att hämta data från textfield

  void _addTask() {
    setState(() {
      String taskText = _taskController.text; // hämta värdet från textfield

      if (taskText.isNotEmpty) {
        // error check
        widget.addTaskCallback(taskText);
      }

      _taskController.clear(); // Clear TextField

      Navigator.pop(context); // hoppa tillbaka till MyHomePage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 40),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: _taskController,
                maxLines: null,
                keyboardType: TextInputType
                    .multiline, // expandar textfield vertikalt om input inte får plats
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: _addTask,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    Text(
                      'ADD',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
