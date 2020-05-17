import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _chatController = new TextEditingController();

  void _submitText(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(
              "Chat Room",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Text('Test Screen'),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16.0),
                              border: OutlineInputBorder(),
                              hintText: 'Type something...'),
                          controller: _chatController,
                          onSubmitted:
                              _submitText, // 綁定事件給_submitText這個Function
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => _submitText(_chatController.text),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
