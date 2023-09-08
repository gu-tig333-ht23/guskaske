import 'package:flutter/material.dart';
import './task.dart';

class TodoItem extends StatelessWidget {
  // Skapar det visuella för klassen [Task]
  final Task task;
  TodoItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !task.completed // if statement för checkbox
                  ? const Icon(
                      Icons.check_box_outline_blank,
                    )
                  : const Icon(Icons.check_box),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(task.task,
                    style: !task.completed
                        ? Theme.of(context).textTheme.headlineSmall
                        : Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(decoration: TextDecoration.lineThrough)),
              )),
              Icon(Icons.close)
            ],
          ),
        ),
        Divider(
          thickness: 0.3,
          height: 4,
        )
      ],
    );
  }
}
