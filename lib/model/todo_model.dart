import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  int duration;

  @HiveField(3)
  int remainingTime;

  @HiveField(4)
  String status;

  TodoModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.remainingTime,
    this.status = "TODO",
  });
}
