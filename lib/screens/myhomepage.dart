import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import '../widgets/todo_item.dart';
import '../widgets/build_theme_toggle_button.dart';
import 'add_view.dart';
import 'package:provider/provider.dart';
import '../model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.scrim,
        title: Text(title),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 70),
            child: Row(
              children: [
                Icon(Icons.nightlight),
                buildThemeToggleButton(context),
                Icon(Icons.sunny),
              ],
            ),
          ),
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
        final task = tasks[index];
        final key = ValueKey<String?>(task.id);

        return TodoItem(task, key: key);
      },
      itemCount: itemCount,
    );
  }
}
