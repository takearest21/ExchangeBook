import 'package:bookSwap/pages/add_book_page.dart';
import 'package:bookSwap/pages/favourite_page.dart';
import 'package:bookSwap/pages/home_page.dart';
import 'package:bookSwap/pages/landing_page.dart';
import 'package:bookSwap/pages/my_book_page.dart';
import 'package:bookSwap/pages/search_page.dart';
import 'package:bookSwap/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bookSwap/constants.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  //inside _DashboardScreenState class

  PageController _pageController;
  int _page = 0;

  ScrollController _hideBottomNavController;

  bool _isVisible;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _isVisible = true;
    _hideBottomNavController = ScrollController();
    print("123");
    _hideBottomNavController.addListener(
      () {
        print("123");
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible)
            setState(() {
              _isVisible = false;
            });
        }
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible)
            setState(() {
              _isVisible = true;
            });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

//inside _DashboardScreenState class

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "Book Swap",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Stack(children: <Widget>[
            Positioned(
                top: 8,
                right: 5,
                child: Container(
                  height: 20,
                  width: 20,
                  child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        "123",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      )),
                )),
            Center(
              child: IconButton(
                icon: Icon(Icons.send),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, '/dm');
                },
              ),
            )
          ])
        ], // this is all you need
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Login First'),
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
            ),
            ListTile(
              title: Text('Setting'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Discramer'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: new PageView(
        children: [
          new AddBookPage(),
          new SearchPage(),
          new LandingPage(),
          new FavouritePage(),
          new MyBookPage()
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.white,
        ), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add,color: FontColor.defaultColor,),
              title: Text('',style: MyTextStyleBase.whiteBlackTextStyle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,color: FontColor.defaultColor,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: FontColor.defaultColor,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark,color: FontColor.defaultColor,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books,color: FontColor.defaultColor,),
              title: Text(''),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  //inside _DashboardScreenState class

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
