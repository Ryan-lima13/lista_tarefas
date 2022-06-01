import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/lista.dart';

class TodoRepositories{
  TodoRepositories(){
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }
   late SharedPreferences sharedPreferences;
  void saveTodoList(List<Lista> todos){
    final  String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);

  }
}