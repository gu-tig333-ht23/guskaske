import 'package:flutter/material.dart';
import './task.dart';
import './todo_item.dart';
import './add_view.dart';

// callback från addview för att uppdatera listview
typedef AddTaskCallback = void Function(String task);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'TIG169 TODO',
      ),
    );
  }
}

List<Task> tasks = [
  Task('Write a book'),
  Task('Do homework'),
  Task('Tidy room', completed: true),
  Task('Watch TV'),
  Task('Nap'),
  Task('Shop groceries'),
  Task('Have fun'),
  Task('Meditate'),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void addTask(String task) {
    setState(() {
      tasks.add(Task(task));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            // filtrering av tasks
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(value: 0, child: Text('all')),
                PopupMenuItem<int>(value: 1, child: Text('done')),
                PopupMenuItem<int>(value: 2, child: Text('undone'))
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                print('all'); // placeholder
              } else if (value == 1) {
                print('done'); // placeholder
              } else if (value == 2) {
                print('undone'); // placeholder
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoItem(tasks[index]);
        },
        itemCount: tasks.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddView(
                      title: widget.title,
                      addTaskCallback: addTask,
                    )),
          );
        },
        tooltip: 'Add new task',
        shape: CircleBorder(),
        child: Center(
          child: const Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
