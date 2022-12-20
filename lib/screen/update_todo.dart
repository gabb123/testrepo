import 'package:api_assignment/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class PatchUpdateTodo extends StatefulWidget {
  final Map? todo;

  const PatchUpdateTodo({Key? key, this.todo}) : super(key: key);

  @override
  State<PatchUpdateTodo> createState() => _PatchUpdateTodoState();
}

class _PatchUpdateTodoState extends State<PatchUpdateTodo> {

  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  bool isEdit = false;

  @override
  void initState(){
    super.initState();
    final todo = widget.todo;
    if (todo != null){
      isEdit = true;
      final title = todo['title'];
      titleController.text = title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( isEdit ? 'Edit Todo' : 'Update Todo Data'),
      ),

      body: Container(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Title you want to update',
                  labelText: 'Please dont leave this blank',
                ),
              ),

              ElevatedButton(
                  onPressed: isEdit ? updateData : submitData,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(isEdit ? 'Update' : 'Submit'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    final title = titleController.text;
    final body = {
      'title' : title,
      'completed' : false,
    };
  }
  Future<void> submitData() async {
    final title = titleController.text;
    final body = {
      'title' : title,
      'completed' : false,
    };
    TodoRepository();
  }
}




