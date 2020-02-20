import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Last Stop',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Last Stop'), // App Bar
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView(
        padding: EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        ),
        children: <Widget>[
          Card(
            color: Colors.tealAccent[200],
            child: Center(
            child: Text("Student Information", 
            style:TextStyle(
              fontSize: 20.0 ,
              color: Colors.white,
              ),
            ),
          ),
          ),
          Card(
            color: Colors.black,
            child: Center(
            child: Text("Student Information", 
            style:TextStyle(
              fontSize: 20.0 ,
              color: Colors.white,
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
