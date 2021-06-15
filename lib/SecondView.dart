import 'package:flutter/material.dart';
import 'package:myapp/Todo.dart';

class SecondView extends StatefulWidget {
  Todo todo;
  bool isEdit = false;

  SecondView({this.todo, this.isEdit = false});


  @override
  SecondViewState createState() => SecondViewState();
}

  class SecondViewState extends State<SecondView>{
    final List<String> activities = <String>[];

    final TextEditingController activityController = TextEditingController();
   void addItemToList(){
    setState(() {
      activities.insert(0,activityController.text);
    });
  }
  @override  
  Widget build(BuildContext context) {
    if(widget.todo !=null){
      //print('todo är ${widget.todo.toJson()}  ${widget.isEdit}');
      activityController.text = widget.todo.name;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.purple,
        title: Text('Add new Activity',
            style: TextStyle(color: Colors.white, 
            fontSize: 26)),
      ),
      body: Column( 
        children: [ 
          TextField(
              controller: activityController,
              style: TextStyle(
              fontSize: 26, 
              fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What will you do today?',
                hintStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            RaisedButton(
              color: Colors.purple,
            child: Text('Add',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
            onPressed: () {
              final todo  = Todo(activityController.text, false);
              if(widget.isEdit){
                todo.id = widget.todo.id;
                todo.done = widget.todo.done;
              }
              //print('data is ${todo.toJson()}');
              Navigator.pop(context, todo);
            },
          ),
        ]
      ),
    );
  }
  }