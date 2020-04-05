import 'dart:async';
import 'package:flutter/material.dart';
void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}
 class Todo
 {
   bool completed = false;
   String title;
   Todo(this.title);
 }

class _TodoListPageState extends State<TodoListPage> {
      var _todoController = TextEditingController();
   StreamController<List<Todo>> streamController = StreamController();
   List<Todo> items = <Todo>[];

void _addTodo(Todo todo)
{
  items.add(todo);
  streamController.add(items);
}
void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget _buildListTile (AsyncSnapshot snapshot, int index) { 
 
    var title = snapshot.data[index].title;
    return ListTile(
      title: Text("$title"),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Todo List")),
        body: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("할일 추가"),
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                onPressed: () { 
                    _addTodo(Todo(_todoController.text));
                },
              ),
            ),
            Row(    children: <Widget>[
                    Expanded(
                      child:TextField(
                        controller:_todoController,
                        ),)],
            ),
            Flexible(
              child: StreamBuilder(
                stream: streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text("no data");
                  } else { 
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => _buildListTile(snapshot, index),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}