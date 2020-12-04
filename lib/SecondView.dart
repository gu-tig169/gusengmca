import 'package:flutter/material.dart';

class SecondView extends StatefulWidget {
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
              Navigator.pop(context, activityController.text);
            },
          ),
        ]
      ),
    );
  }
  }