import 'package:bookSwap/pages/book_details_page.dart';
import 'package:bookSwap/pages/chat_room_page.dart';
import 'package:bookSwap/pages/dash_board_screen.dart';
import 'package:bookSwap/pages/direct_message_page.dart';
import 'package:bookSwap/pages/my_book_page.dart';
import 'package:bookSwap/pages/register_page.dart';
import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/splash_page.dart';
import './pages/landing_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Swap',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: DashBoardScreen(),
      routes: {
        '/dashBoard': (BuildContext context) => DashBoardScreen(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
        '/splash': (BuildContext context) => SplashPage(),
        '/landing': (BuildContext context) => LandingPage(),
        '/dm': (BuildContext context) => DirectMessagePage(),
        '/chatroom': (BuildContext context) => ChatRoomPage(),
        '/detail': (BuildContext context) => BookDetailsPage(),
        '/myBook':(BuildContext context)=> MyBookPage(),
      },
    );
  }
}


