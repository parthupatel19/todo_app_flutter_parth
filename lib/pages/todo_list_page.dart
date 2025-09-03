import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/app/routes.dart';
import 'package:todo_task/controller/todo_controller.dart';
import 'package:todo_task/pages/todo_form.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  final TodoController controller = Get.put(TodoController());
  final RxString search = "".obs;

  Color _statusColor(String status){
    switch(status){
      case "TODO":
        return Colors.blueAccent;
      case "In-Progress":
        return Colors.orangeAccent;
      case "Done" :
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const LinearGradient(
        colors: [Color(0xFFfbc2eb), Color(0xFFa6c1ee)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, Get.width, Get.height)) !=
          null
          ? null
          : Colors.white,
      appBar: AppBar(
        title: Text(
            '✨ TODO List',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.deepPurpleAccent,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              child: TextField(
                onChanged: (value)=> search.value = value.toLowerCase(),
                decoration: InputDecoration(
                  hintText: "Search Todos...",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.search,
                  color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
        ),
      ),
      body: Obx((){
        final todoSearch = controller.todos.where((todo){
          final query = search.value;
          return todo.title.toLowerCase().contains(query) || todo.description.toLowerCase().contains(query);
        }).toList();

        if(todoSearch.isEmpty){
          return Center(
            child: Text('No Todos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          itemCount: todoSearch.length,
            itemBuilder: (context, index){
            final todo = todoSearch[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: _statusColor(todo.status).withOpacity(0.2),
                  child: Icon(
                    todo.status == "Done" ? Icons.check_circle :todo.status =="In-Progress" ?Icons.play_circle_fill :Icons.pending_actions,
                    color: _statusColor(todo.status),
                    size: 28,
                  ),
                ),
                title: Text(
                    todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      todo.description,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(todo.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Status: ${todo.status}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _statusColor(todo.status),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                    onPressed: ()=> controller.deleteTodo(index),
                    icon: Icon(
                        Icons.delete_forever,
                      color: Colors.redAccent,
                    ),
                ),
                onTap: ()=>Get.toNamed(
                  AppRoutes.details,
                  arguments: {"index": index}
                ),
              ),
            );
            }
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Get.bottomSheet(
            TodoForm(),
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            )
          );
        },
        backgroundColor: Colors.deepPurpleAccent,
        icon: Icon(Icons.add),
        label: Text('Add Todo'),
      )
    );
  }
}
