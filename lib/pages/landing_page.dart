import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Item 1',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Exchange Book",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true, // this is all you need
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: GridWidget()),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              title: Text(''),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class GridWidget extends StatefulWidget {
  GridViewState createState() => GridViewState();
}

class GridViewState extends State {
  num countValue = 2;

  num aspectWidth = 2;

  num aspectHeight = 1;

  List<String> gridItems = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
    'Twenty'
  ];

  changeMode() {
    if (countValue == 2) {
      setState(() {
        countValue = 1;
        aspectWidth = 3;
        aspectHeight = 1;
      });
    } else {
      setState(() {
        countValue = 2;
        aspectWidth = 2;
        aspectHeight = 1;
      });
    }
  }

  getGridViewSelectedItem(BuildContext context, String gridItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(gridItem),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: RaisedButton(
            onPressed: () => changeMode(),
            child: Text(' Change GridView Mode To ListView '),
            textColor: Colors.white,
            color: Colors.red,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          )),
      Expanded(
        child: GridView.count(
          crossAxisCount: countValue,
          childAspectRatio: (1.0),
          children: gridItems
              .map((data) => GestureDetector(
                  onTap: () {
                    getGridViewSelectedItem(context, data);
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      color: Colors.lightBlueAccent,
                      child: Center(
                          child: Text(data,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                              textAlign: TextAlign.center)))))
              .toList(),
        ),
      ),
    ]));
  }
}
