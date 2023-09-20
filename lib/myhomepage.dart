import 'package:flutter/material.dart';
import './todo_item.dart';
import './add_view.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'task.dart';

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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = context.watch<AppState>().tasks;
    final itemCount = tasks.length;

    return ListView.builder(
      itemBuilder: (context, index) {
        return TodoItem(tasks[index]);
      },
      itemCount: itemCount,
    );
  }
}