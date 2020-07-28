import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bookSwap/rest/card_api.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  
  final _formKey = GlobalKey<FormState>();
final database = BookInfoSqlite();

  BookInfo bookInfo = new BookInfo();
  // Create a Dog and add it to the dogs table.
  @override
  void initState() {
    main();

    bookInfo.contactBookIntro= '1';


    insert(bookInfo);
    getBook();
    // TODO: implement initState
    super.initState();
  }

   insert(BookInfo bookInfo) async{
    final db = await database;
    var res = await db.insert(bookInfo);
    return res;

  }

  
  void main() async{
    
    database.openSqlite();
  }

  void insertBook(book) async{
    database.insert(book);
  }

  void getBook()async{

    database.queryAll();
    
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text("Book Name"),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("intro"),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Book News"),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Book Status"),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
