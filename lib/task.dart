class Task {
  // klass för att skapa todo tasks

  final String task;
  bool completed;
  final String? id;

  Task(this.task, {this.completed = false, this.id});

  factory Task.fromJson(Map<String, dynamic> json) {
    // convert json format to [Task]
    return Task(json['title'], completed: json['done'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    // convert [Task] to json format
    return {"title": task, 'done': completed};
  }
}
