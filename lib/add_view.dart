import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart';

class AddView extends StatelessWidget {
  // view där nya tasks läggs till
  final String title;
  late BuildContext _context; // Store the context here

  AddView({super.key, required this.title});

  final TextEditingController _taskController = TextEditingController();
  // används för att hämta data från textfield
  final snackBar = SnackBar(
    content: const Text('Item added!'),
    duration: Duration(seconds: 1),
  );

  void addTaskk() async {
    final TextEditingController taskController = TextEditingController();
    String taskText = taskController.text;

    if (taskText.isNotEmpty) {
      await _context.read<AppState>().addTask(taskText);
      taskController.clear();
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
      Navigator.pop(_context);
    } else {
      // Error handling
      showDialog<String>(
        context: _context, // Use _context here
        builder: (BuildContext context) => AlertDialog(
            // ...
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context; // Assign context to the _context variable

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 40),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(title),
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
                onPressed: addTaskk,
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
