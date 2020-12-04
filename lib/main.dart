import 'package:flutter/material.dart';
import 'SecondView.dart';
import 'Todo.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  List<Todo> activities = [Todo('name', false)];

 var filterBy = 'all';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('To-Do-List',
        style: TextStyle(color: Colors.white,
        fontSize: 26,
        ),
       ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              setState(() {
                filterBy = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('All'), value: 'All'),
              PopupMenuItem(child: Text('Done'), value: 'Done'),
              PopupMenuItem(child: Text('Not done'), value: 'Not done'),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(2),
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                var todo =  activities[index];
                return Container(
                  height: 70,
                  margin: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.purple,
                        value: todo.done,
                        onChanged: (bool newValue) {
                          todo.done = newValue;
                          setState(() {
                            
                          });
                        }
                      ),
                       Text(todo.name,
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                       ),
                       CloseButton(      
                         onPressed: () {
                           var removeMe = activities[index];
                           setState(() {
                             activities.remove(removeMe);

                           });
                         },
                       ),
                       Divider(), 
                    ]
                    )
                  );
              }
            )
          )
          
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(

            context, MaterialPageRoute(
              builder: (context) => (SecondView()))

          ); 
        activities.add(Todo(result, false)); 
        setState(() {});
        },
      ),
    );
  }
}
