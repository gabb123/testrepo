// fake server
import 'package:api_assignment/model/todo.dart';

abstract class Repository {
  Future<List<Todo>> getTodoList();
  Future<String> patchCompleted(Todo todo);
  // Future<String> putCompleted(Todo todo);
  Future<String> delTodo(Todo todo);
  Future<String> postTodo(Todo todo);
}