import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_task/controller/todo_controller.dart';

class TodoDetailPage extends StatelessWidget {
  TodoDetailPage({super.key});

  final TodoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final int index = args["index"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Todo Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 8,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: Obx((){
          final todo = controller.todos[index];
          double progress = todo.remainingTime/(todo.duration == 0 ? 1 : todo.duration);
          return Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      todo.description.isEmpty ? "No Description" : todo.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),

                    Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: todo.status =="Done" ? Colors.green : Colors.orange,
                        ),
                        SizedBox(width: 8,),
                        Text('Status: ${todo.status}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(Icons.timer,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 8,),
                        Text("Remaining Time: ${todo.remainingTime}sec",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      backgroundColor: Colors.grey[300],
                      color: progress > 0.5 ? Colors.green : progress > 0.2 ? Colors.orange : Colors.red,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        "${(progress * 100).toStringAsFixed(0)}% Remaining",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple),
                      ),
                    ),

                    Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _button(
                            icon: Icons.play_circle_fill,
                            label: "Start",
                            color: Colors.greenAccent,
                            onPressed: () => controller.starterTime(index),
                          ),
                          _button(
                            icon: Icons.pause,
                            label: "Pause",
                            color: Colors.orangeAccent,
                            onPressed: () => controller.pauseTimer(index),
                          ),
                          _button(
                            icon: Icons.stop,
                            label: "Stop",
                            color: Colors.redAccent,
                            onPressed: () => controller.stopTimer(index),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _button({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
}){
    return ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 6,
      ),
    );
}
}
