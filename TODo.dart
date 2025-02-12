import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> _todoItems = [
    TodoItem(task: 'Buy groceries', isDone: false),
    TodoItem(task: 'Complete Flutter project', isDone: false),
    TodoItem(task: 'Read a book', isDone: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: _todoItems.map((todoItem) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: CheckboxListTile(
              title: Text(todoItem.task),
              value: todoItem.isDone,
              onChanged: (bool? value) {
                setState(() {
                  todoItem.isDone = value ?? false;
                });
              },
              secondary: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _renameTodoItem(todoItem);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _todoItems.remove(todoItem);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _addTodoItem() {
    setState(() {
      _todoItems.add(TodoItem(task: 'New Task', isDone: false));
    });
  }

  void _renameTodoItem(TodoItem todoItem) async {
    TextEditingController _controller = TextEditingController(text: todoItem.task);
    String? newTaskName = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename Task'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter new task name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              child: Text('Rename'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (newTaskName != null && newTaskName.isNotEmpty) {
      setState(() {
        todoItem.task = newTaskName;
      });
    }
  }
}

class TodoItem {
  String task;
  bool isDone;

  TodoItem({required this.task, required this.isDone});
}
