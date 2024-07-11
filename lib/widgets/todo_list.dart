import 'package:flutter/material.dart';

import '../modals/todo_item.dart';


class TodoList extends StatelessWidget {
  final List<TodoItem> todos;

  TodoList({required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index].title),
          subtitle: Text(todos[index].description),
        );
      },
    );
  }
}
