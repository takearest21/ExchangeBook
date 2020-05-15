import 'package:flutter/material.dart';

class DirectMessagePage extends StatefulWidget {
  @override
  _DirectMessagePageState createState() => _DirectMessagePageState();
}

class _DirectMessagePageState extends State<DirectMessagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Icon(Icons.send,color: Colors.black,),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top:10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/chartroom');
                          },
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child:
                                    Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(
                                "Can i use XXX book to change your XXX book?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              subtitle: Row(
                                children: <Widget>[
                                  Text("Online",
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white, size: 30.0),onTap: (){
                                     Navigator.pushNamed(context, '/chatroom');
                                  },),
                        )));
              },
            ),
          )),
    );
  }
}
