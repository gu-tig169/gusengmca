import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Colors.blue),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow,
        title: Text('To-Do List',
            style: TextStyle(color: Colors.black, 
            fontSize: 30)
            ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, 
            color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('All  Done  Undone'),

                  //Enda funktionen jag inte riktigt lyckades implementera var drop-down-menyn för att se "All", "Done" och "Undone". Tacksam för feedback på hur man bäst gör det :)

                );
                }
              );
            },
          ),
        ],
      ),
      body: Center(
        child: (_list()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondView()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _list() {
    return ListView(
      children: [
        _item('Gå och fiska'),
        Divider(),
        _item('Äta på restaurang'),
        Divider(),
        _item('Lära mig Flutter'),
        Divider(),
        _item('Spela Fortnite'),
        Divider(),
        _item('Handla'),
        Divider(),
        _item('Plocka svamp'),
        Divider(),
        _item('Träna'),
        Divider(),
        _item('Bygga Lego'),
      ],
    );
  }

  Widget _item(text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        Checkbox(value: false, onChanged: _onChanged),
        Text(text, style: TextStyle(fontSize: 25)),
        Icon(
          Icons.close_outlined,
        ),
      ]
      ),
    );
  }
  void _onChanged(bool value) {
  }
}

//Andra vyn där man lägger till nya aktiviteter

class SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow,
        title: Text('To-Do List',
            style: TextStyle(color: Colors.black, fontSize: 30)),
      ),
      body: Column( 
        children: [ 
          _whatToDoField(),
          RaisedButton(
            onPressed: () {
          },
          child: Text('+ Add'),
          ), 
        ]
      ),
    );
  }

//Här matar man i ett senare skede in nya aktiviteter att lägga till.

  Widget _whatToDoField() {
    return Container(
      height: 60,
      margin: EdgeInsets.all(5.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'What are you going to do?',
            border: const OutlineInputBorder()),
      ),
    );
  }
}
