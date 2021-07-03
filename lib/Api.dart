import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Todo.dart';

class ApiService {
  static final String apiUrl = 'https://todoapp-api-6tdiq.ondigitalocean.app';
  static final String apiKey = '79f8b7e4-23ba-40b3-9c31-0a77562a646d';

static Future<http.Response> addTodo(Todo todo, {String name}) async {
  Map<String,dynamic> json = todo.toJson();
  var bodyString = jsonEncode(json);
  return await http.post(
    '$apiUrl/todos?key=$apiKey',
    body: bodyString,
    headers: <String,String>{'Content-Type': 'application/json'},
  );
}

 static Future deleteTodo(String id) async {
    return await http.delete('$apiUrl/todos/$id?key=$apiKey');
  }

  static Future<List<Todo>> getTodos() async{
    var response = await http.get('$apiUrl/todos?key=$apiKey');
    String bodyString = response.body;
    var json = jsonDecode(bodyString);
    return json.map<Todo>((data){
      return Todo.fromJson(data);
    }).toList();
  }

  static Future<http.Response> putTodo(Todo todo) async {
    String id = todo.id;
    Map<String, dynamic> json = todo.toJson();
    var bodyString = jsonEncode(json);
    print(bodyString);
    return await http.put('$apiUrl/todos/$id?key=$apiKey',
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
      ); 
  }
 }