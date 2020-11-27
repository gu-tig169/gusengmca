import 'package:flutter/material.dart';
import 'SecondView.dart';
import 'Item.dart ';

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
  final List<String> activities = <String>['Fiska', 'Städa', 'Åka båt', 'Programmera'];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              PopupMenuItem(child: Text('All'), value: 'All'),
              PopupMenuItem(child: Text('Done'), value: 'Done'),
              PopupMenuItem(child: Text('Undone'), value: 'Undone'),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {

                return Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Text('${activities[index]}',
                      style: TextStyle(fontSize: 26),
                       ),
                       CloseButton(      
                         onPressed: () {
                           var removeMe = activities[index];
                           setState(() {
                             activities.remove(removeMe);

                           });
                         },
                       ) 
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

            context, MaterialPageRoute(builder: (context) => (SecondView()))

          ); 
        activities.add(result);
        setState(() {});
        },
      ),
    );
  }
}
