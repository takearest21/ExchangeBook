import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.library_books,
                color: Colors.black,
                size: 100.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              SizedBox(height: 25,),
              FlatButton(
                onPressed: () {
                  /*...*/
                    Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Login",
                ),
              ),
              SizedBox(height: 25,),
               FlatButton(
                onPressed: () {
                  /*...*/
                 Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Register",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
