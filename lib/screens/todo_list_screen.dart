import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../modals/todo_item.dart';
import 'add_todo_screen.dart';

import '../widgets/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final LocalStorage storage = LocalStorage('todo_app');
  List<TodoItem> _todoList = [];
  List<TodoItem> _filteredTodoList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    await storage.ready;
    List<dynamic> savedTodos = storage.getItem('todos') ?? [];
    setState(() {
      _todoList = savedTodos.map((item) => TodoItem.fromJson(item)).toList();
      _filteredTodoList = List.from(_todoList);
    });
  }

  void _filterTodos(String query) {
    setState(() {
      _filteredTodoList = _todoList
          .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addTodo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodoScreen()),
    );
    if (result != null && result is TodoItem) {
      setState(() {
        _todoList.add(result);
        _filteredTodoList.add(result);
        storage.setItem('todos', _todoList.map((item) => item.toJson()).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _filterTodos,
            ),
          ),
        ),
      ),
      body: TodoList(todos: _filteredTodoList),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
