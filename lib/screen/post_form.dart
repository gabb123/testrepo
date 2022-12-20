import 'package:api_assignment/controller/todo_controller.dart';
import 'package:api_assignment/model/todo.dart';
import 'package:api_assignment/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  var todoController = TodoController(TodoRepository());
  final userIdController = TextEditingController();
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final completedController = TextEditingController();
  var trueOrFalse ='';
  bool completeTrueOrFalse = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),

      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                enabled: false,
                controller: userIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Your default Compnay Number #1',),
              ),

              TextFormField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ex. 198',
                  labelText: 'Please enter a unique Identification Number',
                ),
              ),


              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Ex. Application Programming Interface',
                  labelText: 'Please enter a title',
                ),
              ),


              const SizedBox(height: 20,),

              CheckboxListTile(
                value: completeTrueOrFalse,
                onChanged: (val){
                  setState(() {
                    completeTrueOrFalse = val!;
                  }
                  );
                },
                activeColor: const Color(0xFF66BB6A),
                title: const Text('Check the box if you want this to be completed'),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: (){
                    int idUser = 1;
                    final idNumber = idController.text;
                    final titleUser = titleController.text;
                    final complete = completeTrueOrFalse;
                    Todo todo = Todo(userId: idUser, id : idNumber, title: titleUser, completed: complete);
                    todoController.postTodo(todo);
                    Navigator.pop(context, todoController);

                  },
                  child: const Text('Submit')
              )
            ],
          ),
        ),
      ),
    );
  }
}
