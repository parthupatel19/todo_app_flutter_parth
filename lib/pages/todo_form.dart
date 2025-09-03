import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class TodoForm extends StatelessWidget {
  TodoForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final timeController = TextEditingController();
  final TodoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Form(
        key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                    'Add New Todo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 20),

                _commonTextField(
                  controller: titleController,
                  label: "Title",
                  icon: Icons.title,
                  validator: (v)=> v!.isEmpty ? "Enter title" : null,
                ),
                SizedBox(height: 12),
                _commonTextField(
                  controller: descController,
                  label: "Description",
                  icon: Icons.description,
                ),
                SizedBox(height: 12),
                _commonTextField(
                  controller: timeController,
                  label: "Time (in seconds)",
                  icon: Icons.timer,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter time";
                    }
                    final num? parsed = int.tryParse(value);
                    if (parsed == null || parsed <= 0) {
                      return "Enter a valid number greater than 0";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent.shade400,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 12
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                      ),
                        onPressed: (){
                        if(_formKey.currentState!.validate()){
                          final todo = TodoModel(
                              title: titleController.text,
                              description: descController.text,
                              duration: int.parse(timeController.text),
                              remainingTime: int.parse(timeController.text),
                          );
                          controller.addTodo(todo);
                          Get.back();
                        }
                        },
                      icon: Icon(Icons.save),
                      label: Text(
                          'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                      ),
                      onPressed: ()=> Get.back(),
                      icon: Icon(Icons.cancel),
                      label: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _commonTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
}){
    return TextFormField(
     controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor:  Colors.white.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        )
      ),
    );
  }
}
