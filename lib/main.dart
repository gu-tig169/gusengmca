import 'package:flutter/material.dart';
import 'package:myapp/Api.dart';
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

  List<Todo> activities = [];
  List<Todo> activitiesTemp = [];
  FilterState state = FilterState.ALL;

  @override
  void initState() {
    
    super.initState();
    fetchData();
  }

  fetchData() async{
    print('Hämta todos');
    var data = await ApiService.getTodos();
    print(data);
    activities.clear();
    activities.addAll(data);
    refreshTempList();
    setState(() {
      
    });
  }

  saveTodo(Todo todo) async{
    var res = await ApiService.addTodo(todo);
  }

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
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('All'), value: 'All' ,),
              PopupMenuItem(child: Text('Done'), value: 'Done'),
              PopupMenuItem(child: Text('Not done'), value: 'Not done'),
            ],

            onSelected: (value) {
            //print("clicked ${value}");
              if(value=="All"){
                state = FilterState.ALL;
                refreshTempList();
                setState(() {});
              }
              else if(value=="Done"){
                state = FilterState.DONE;
                refreshTempList();
                setState(() {});
                //print('size is ${activitiesTemp.length}');
              }else if(value == "Not done"){
                state = FilterState.NOTDONE;
                refreshTempList();
                setState(() {});
              }
            },
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
                itemCount: activitiesTemp.length,
                itemBuilder: (BuildContext context, int index) {
                var todo =  activitiesTemp[index];
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
                          refreshTempList();
                          setState(() {       
                          });
                        }
                      ),
                      GestureDetector(
                        onTap: () async{
                          //print('$index ${activities[index].name}');
                        var todo = await Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => (SecondView(todo: activities[index], isEdit: true,)))
                        ); 
                    if(todo == null){
                      return;
                    }

                    final result = ApiService.putTodo(todo);
                    print('$result');
                    activities[index] = todo;
                    refreshTempList();
                    setState(() {
                      
                    });

                        },child: Text(todo.name,
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                       ),
                      ),
                       CloseButton(      
                         onPressed: () {
                           remove(index);
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
       if(result == null){
         return;
       }

          add(result);
          setState(() {});
          saveTodo(activities.last); // Sparar todo
        },
      ),
    );
  }

  remove(index) async{
    final response = await ApiService.deleteTodo(activities.removeAt(index).id);
    print('delete $response');
    refreshTempList();
    setState(() {      
    });
  }

  add(Todo todo){
    activities.add(todo);
    refreshTempList();
  }

  refreshTempList(){
    switch(state){
      case FilterState.ALL:
      activitiesTemp = List.from(activities);
      break;
      case FilterState.DONE:
       activitiesTemp = activities.where((element) => element.done == true).toList();
      break;
      case FilterState.NOTDONE:
        activitiesTemp = activities.where((element) => element.done == false).toList();
      break;
    }
  }
}
  enum FilterState{
    ALL, DONE, NOTDONE
  }