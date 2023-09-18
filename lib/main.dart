import 'package:flutter/material.dart';
import './task.dart';
import './todo_item.dart';
import './add_view.dart';
import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  final List<Task> _tasks = [
    Task('Write a book'),
    Task('Do homework'),
    Task('Tidy room', completed: true),
    Task('Watch TV'),
    Task('Nap'),
    Task('Shop groceries'),
    Task('Have fun'),
    Task('Meditate'),
  ];

  var selectedFilter = 'all';

  List<Task> get tasks {
    switch (selectedFilter) {
      case 'all': // returns all tasks
        return _tasks;
      case 'done': // returns done tasks
        return _tasks.where((element) => element.completed == true).toList();
      case 'undone': // returns undone tasks
        return _tasks.where((element) => element.completed == false).toList();
      default:
        return _tasks; // Add a return statement here
    }
  }

  void setFilter(value) {
    // gets value from popupmenu for filtering of _tasks
    selectedFilter = value;
    notifyListeners();
  }

  void addTask(task) {
    // adds new task created in AddView
    _tasks.add(Task(task));
    notifyListeners();
  }

  void removeTask(task) {
    // removes task from List Task [_tasks]
    _tasks.remove(task);
    notifyListeners();
  }

  void checkBoxSwitch(task) {
    // changes completion status of Task[task]
    task.completed = !task.completed;
    notifyListeners();
  }
}

void main() {
  AppState state = AppState();
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            // filtrering av tasks
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(value: 'all', child: Text('all')),
                PopupMenuItem<String>(value: 'done', child: Text('done')),
                PopupMenuItem<String>(value: 'undone', child: Text('undone'))
              ];
            },
            onSelected: (value) {
              context.read<AppState>().setFilter(value);
            }, //
          ),
        ],
      ),
      body: ListViewBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(
                title: title,
              ),
            ),
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

class ListViewBuilder extends StatelessWidget {
  // separated to not rebuild whole MyHomePage on change of state.
  const ListViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var tasks = context.watch<AppState>().tasks;
    return ListView.builder(
      itemBuilder: (context, index) {
        return TodoItem(tasks[index]);
      },
      itemCount: tasks.length,
    );
  }
}
