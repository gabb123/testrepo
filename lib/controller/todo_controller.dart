import 'package:api_assignment/model/todo.dart';
import 'package:api_assignment/repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  // get method
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  // patch method
  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  // put method
  //Future<String> updatePutCompleted(Todo todo) async {
  //  return _repository.putCompleted(todo);
  //}

  // delete method
  Future<String> deleteTodo(Todo todo) async {
    return _repository.delTodo(todo);
  }

  // post method
  Future<String> postTodo(Todo todo) async {
    return _repository.postTodo(todo);
  }
}