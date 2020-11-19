import 'package:flutter/material.dart';
import 'SecondView.dart';

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('${activities[index]}',
                      style: TextStyle(fontSize: 26),
                       ),
                       GestureDetector( //Hade enormt svårt för att implementera både Cancel-button och checkboxen, tacksam för svar på hur man gör detta på bästa sätt. 
                         child: Icon(Icons.cancel_outlined),
                         onTap: () {
                         }
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
