import 'package:flutter/material.dart';
import './task.dart';
import './todo_item.dart';
import './add_view.dart';
import 'package:provider/provider.dart';
import 'api_methods.dart';

class AppState extends ChangeNotifier {
  List<Task> _tasks = [];

  void fetchList() async {
    var tasks = await ApiMethods.getList();
    _tasks = tasks;
    notifyListeners();
  }

  ApiMethods apiMethods = ApiMethods(); // Create an instance of ApiMethods

  //final List<Task> _tasks = ApiMethods.getList();

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

  void addTask(task) async {
    // adds new task created in AddView
    Task newTask = Task(task);

    await apiMethods.addTask(newTask);
    fetchList();
  }

  void removeTask(task) async {
    // removes task from List Task [_tasks]
    await apiMethods.removeTask(task);
    fetchList();
  }

  void checkBoxSwitch(task) async {
    // changes completion status of Task[task]
    Task onChange = task;
    onChange.completed = !onChange.completed;
    await apiMethods.updateTask(task);
    fetchList();
  }
}

void main() {
  AppState state = AppState();

  state.fetchList(); // updates Tasks list on startup
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
          //_doStuff();
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
