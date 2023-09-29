import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../model.dart';

class TodoItem extends StatefulWidget {
  // Skapar det visuella för klassen [Task]
  final Task task;
  // Modify the constructor to accept a Key? parameter.
  const TodoItem(this.task, {Key? key}) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _textEditingController;
  bool _isEditing = false; // Track edited text

  final snackBarSave = SnackBar(
    content: const Text('Edit saved'),
    duration: Duration(seconds: 2),
  );

  final snackBarDiscard = SnackBar(
      content: const Text('Edit discarded'), duration: Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.task.task);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(1),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<AppState>().checkBoxSwitch(widget.task);
                },
                child: !widget.task.completed // if statement för checkbox
                    ? const Icon(
                        Icons.check_box_outline_blank,
                      )
                    : const Icon(Icons.check_box),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: (newText) {
                      setState(
                        () {
                          _isEditing = true;
                        },
                      );
                    },
                    decoration: InputDecoration(border: InputBorder.none),
                    style: !widget.task.completed
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(decoration: TextDecoration.lineThrough),
                  ),
                ),
              ),
              if (_isEditing)
                Row(
                  children: [
                    Text(
                      'edited',
                      style: TextStyle(color: Colors.amber),
                    ),
                    GestureDetector(
                      // button to save edited task
                      onTap: () {
                        widget.task.task = _textEditingController.text;
                        context.read<AppState>().editTaskText(widget.task);
                        _isEditing = false;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarSave);
                      },
                      child: Icon(Icons.save),
                    ),
                    GestureDetector(
                      // button to discard changes
                      onTap: () {
                        _textEditingController.text = widget.task.task;
                        context.read<AppState>().editTaskText(widget.task);

                        _isEditing = false;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarDiscard);
                      },
                      child: Icon(Icons.undo_sharp),
                    ),
                  ],
                ),
              GestureDetector(
                onTap: () {
                  context.read<AppState>().removeTask(widget.task);
                },
                child: Icon(Icons.close),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1.5,
          height: 2,
        )
      ],
    );
  }
}
