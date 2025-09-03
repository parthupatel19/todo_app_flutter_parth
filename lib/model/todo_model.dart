import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject{
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

  late RxInt remainingTimeRx;
  late RxString statusRx;

  TodoModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.remainingTime,
    this.status = "TODO",
  }) {
    remainingTimeRx = remainingTime.obs;
    statusRx = status.obs;
  }
}
