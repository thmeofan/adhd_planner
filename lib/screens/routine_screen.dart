import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  List<Todo> _todos = [];
  int _completedTodos = 0;

  void _addTodo(String title) {
    setState(() {
      _todos.add(Todo( title: 'title', completed: true));
    });
  }

  void _toggleCompleted(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
      if (todo.completed) {
        _completedTodos++;
      } else {
        _completedTodos--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          // Progress checker
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _completedTodos.toString() + '/' + _todos.length.toString(),
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Todo list
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Checkbox(
                    value: _todos[index].completed,
                    onChanged: (value) {
                      _toggleCompleted(_todos[index]);
                    },
                  ),
                  trailing: Text(_todos[index].title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Todo {
  String title;
  bool completed;

  Todo({required this.title, required this.completed});
}