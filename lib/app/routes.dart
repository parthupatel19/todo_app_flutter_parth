import 'package:get/get.dart';

import '../pages/todo_detail_page.dart';
import '../pages/todo_list_page.dart';

class AppRoutes{
  static const todoList = '/';
  static const details = '/details';

  static final routes = [
    GetPage(name: todoList, page: () => TodoListPage()),
    GetPage(name: details, page: () => TodoDetailPage()),
  ];
}