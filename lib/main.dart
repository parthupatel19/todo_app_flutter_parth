import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_task/app/routes.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/service/notification_ser.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      initialRoute: AppRoutes.todoList,
      getPages: AppRoutes.routes,
    );
  }
}
