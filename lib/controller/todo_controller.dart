import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/service/notification_ser.dart';

class TodoController extends GetxController{
  var todos = <TodoModel>[].obs;
  late Box<TodoModel> todobox;
  final Map<TodoModel, Timer> timers = {};

  @override
  void onInit()async{
    super.onInit();
    await _box();
    _load();
  }

  Future<void> _box()async{
    todobox = await Hive.openBox<TodoModel>('todos');
  }

  void _load()async{
    todos.value = todobox.values.toList();
  }

  void addTodo(TodoModel todo){
    todobox.add(todo);
    todos.add(todo);
  }

  void deleteTodo(TodoModel todo){
    todo.delete();
    todos.remove(todo);
    pauseTimer(todo);
  }

  void starterTime(TodoModel todo){

    if(todo.remainingTimeRx.value <= 0) return;

    todo.statusRx.value = "In Progress";
    timers[todo] = Timer.periodic(Duration(seconds: 1), (timer){
      if(todo.remainingTimeRx.value > 0){
        todo.remainingTimeRx.value--;
      }else{
        todo.statusRx.value = "Done";
        pauseTimer(todo);
        _showNoti(todo);
      }
    });
  }

  void pauseTimer(TodoModel todo){
    timers[todo]?.cancel();
    timers.remove(todo);
  }

  void stopTimer(TodoModel todo){
    pauseTimer(todo);
    todo.remainingTimeRx.value = todo.duration;
    todo.statusRx.value = "TODO";
  }

  void _showNoti(TodoModel todo)async{
    await NotificationService.showNoti("TODO Completed!", "${todo.title} is done !");
  }

}