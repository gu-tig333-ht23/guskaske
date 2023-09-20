import 'task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiMethods {
  // ignore: non_constant_identifier_names
  static String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
  static String key = 'd6f6b5d3-bcdc-4901-91c5-4bb68ed3c485';

  static Future<List<Task>> getList() async {
    // gets list from api json items and converts them to a [List] of class [Task]
    Uri url = Uri.parse('$ENDPOINT/todos?key=$key');

    http.Response response = await http.get(url);
    String body = response.body;

    List<dynamic> jsonResponse =
        jsonDecode(body); // converts body to list of json objects

    List<Task> tasks = jsonResponse
        .map((json) => Task.fromJson(json))
        .toList(); // takes every item in jsonResponseList and returns items as [List] of class [Task]

    return tasks;
  }

  static Future<String> getKey() async {
    // returns API key
    http.Response response = await http.get(Uri.parse('$ENDPOINT/register'));
    return response.body;
  }

  Future<void> addTask(Task task) async {
    // uploads created [Task] to api in json format
    await http.post(Uri.parse('$ENDPOINT/todos?key=$key'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()));
  }

  Future<void> removeTask(task) async {
    // Deletes task from API
    var id = task.id;
    await http.delete(Uri.parse('$ENDPOINT/todos/$id?key=$key'));
  }

  Future<void> updateTask(Task task) async {
    ///Update todo with :id
    ///Takes a Todo as payload (body), and updates title and done for the
    ///already existing Todo with id in URL.
    var id = task.id;
    await http.put(Uri.parse('$ENDPOINT/todos/$id?key=$key'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()));
  }
}
