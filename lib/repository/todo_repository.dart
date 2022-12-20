import 'package:api_assignment/model/todo.dart';
import 'package:api_assignment/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository implements Repository {
  String dataURL = 'https://jsonplaceholder.typicode.com';

  // delete method
  @override
  Future<String> delTodo(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      return result = 'Deleted';
    }
    );
    return result;
  }

  // get method
  @override
  Future<List<Todo>> getTodoList() async{
    // future async
    List<Todo> todoList = [];
    // https://jsonplaceholder.typicode.com/todos
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    print('status code: ${response.statusCode}');
    var body = json.decode(response.body); // convert
    // parse
    for(var i = 0; i < body.length; i++){
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }


  // patch method
  // patch modify passed variable
  @override
  Future<String> patchCompleted(Todo todo) async {
    var url= Uri.parse('$dataURL/todos/${todo.id}');
    String responseData = ''; // call back data
    await http.patch(url, body: {
      'completed': (!todo.completed!).toString(),
    },
      headers: {'Authorization': 'your_token'}
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body); // homepage data
      print(result);
      return responseData = result['completed'];
    }
    ); // bool? to String
    return 'Completed : $responseData';
  }

  // put method
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    String responseData = '';
    await http.put(url,
        body: {
      'completed': (!todo.completed!).toString(),
        },
      headers: {'Authorization': 'your_token'}
        ).then((response){
          Map<String, dynamic> result = json.decode(response.body);
          print(result);
          return responseData = result['completed'];
    }
    );
    return responseData;
  }

  // post method
  @override
  Future<String> postTodo(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$dataURL/todos/');
    var result = '';
    var response = await http.post(url, body: todo.toJson());
    print(response.statusCode);
    print(response.body);
    return 'true';
  }
}