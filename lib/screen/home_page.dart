import 'package:api_assignment/controller/todo_controller.dart';
import 'package:api_assignment/model/todo.dart';
import 'package:api_assignment/repository/todo_repository.dart';
import 'package:api_assignment/screen/post_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    int count = 0;


    // dependency injection
    var todoController = TodoController(TodoRepository());
    // test
    todoController.fetchTodoList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Assignment'),
      ),

      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot){
          //
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError){
            return const Center(
              child: Text('Error'),
            );
          }

          return ListView.separated(
              itemBuilder: (context, index){
                var todo = snapshot.data?[index];
                return Card(
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  child: Container(
                    height: 75.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text('${todo?.id}')),
                        Expanded(flex: 5, child: Text('${todo?.title}')),
                        Expanded(flex: 3, child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // patch method call
                            InkWell(
                              onTap: (){
                                todoController
                                    .updatePatchCompleted(todo!)
                                    .then((value)
                                {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: const Duration(milliseconds: 1000),
                                    content: Text(value),),);
                                }
                                );
                              },
                                child: buildCallContainer('Patch', const Color(0xFF1976D2))),


                          ],
                        )),
                      ],
                    ),
                  ),
                    onDismissed: (direction) {
                      todoController.deleteTodo(todo!).then((value) => {ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                      duration: const Duration(milliseconds: 1000),
                      content: Text(value),),),});
                      --count;
                    },
                )
                );
              },
              separatorBuilder: (context, index){
                return const Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
    onPressed: () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PostForm())
      );
    },
        child: const Icon(Icons.add),
    ),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 80.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text(title)),
    );
  }
}
