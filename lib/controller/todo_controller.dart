import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:todo_task/model/todo_model.dart';

class TodoController extends GetxController{
  var todos = <TodoModel>[].obs;
  late Box<TodoModel> todobox;
  Map<int, Timer?> timers = {};

  @override
  void onInit()async{
    super.onInit();
    todobox = await Hive.openBox<TodoModel>('todos');
    todos.value = todobox.values.toList();
  }

  void addTodo(TodoModel todo){
    todobox.add(todo);
    todos.value = todobox.values.toList();
  }

  void deleteTodo(int index){
    todobox.deleteAt(index);
    todos.value = todobox.values.toList();
  }

  void updateTodo(int index, TodoModel todo){
    todobox.putAt(index, todo);
    todos.value = todobox.values.toList();
  }

  void starterTime(int index){
    var todo = todos[index];
    if(todo.remainingTime <= 0) return;

    todo.status = "In Progress";
    timers[index]?.cancel();
    timers[index] = Timer.periodic(Duration(seconds: 1), (timer){
      if(todo.remainingTime > 0){
        todo.remainingTime--;
        updateTodo(index, todo);
      }else{
        stopTimer(index);
        todo.status = "Done";
        updateTodo(index, todo);
      }
    });
  }

  void pauseTimer(int index){
    timers[index]?.cancel();
    timers[index] = null;
  }

  void stopTimer(int index){
    timers[index]?.cancel();
    timers[index] = null;
  }

}