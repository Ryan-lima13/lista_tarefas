import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/lista.dart';

const todoListKey = 'todo_list';
class TodoRepositories{

   late SharedPreferences sharedPreferences;
  Future<List<Lista>> getTodoList() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
     return jsonDecoded.map((e) => Lista.fromJson(e)).toList();
    

  }
  void saveTodoList(List<Lista> todos){
    final  String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);

  }
}