import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  List<String> cateogryItems = [
    '#All',
    '#Story',
    '#Love',
    '#Computer',
    '#Sport',
    '#Healthy',
    '#Food',
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Scaffold(
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
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Exchange Book",
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
        body: Column(
          children: <Widget>[
            Container(
                height: 40,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: this.cateogryItems.length,
                        separatorBuilder: (_, __) => SizedBox(width: 5),
                        itemBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Card(
                            child:
                                Center(child: Text('${cateogryItems[index]}')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),             
            Expanded(
              child: 
              Container(
                child:  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 2, //每行三列
                ),
                itemCount: _words.length,
                itemBuilder: (context, index) {
                  //如果到了表尾
                  if (_words[index] == loadingTag) {
                    //不足100条，继续获取数据
                    if (_words.length - 1 < 100) {
                      //获取数据
                      _retrieveData();
                      //加载时显示loading
                      return Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(strokeWidth: 2.0)),
                      );
                    } else {
                      //已经加载了100条数据，不再获取数据。
                      return Container(
                          color: Colors.grey,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "没有更多了",
                            style: TextStyle(color: Colors.grey),
                          ));
                    }
                  }
                  //显示单词列表项
                  return BookCardLayout();
                },
              ),
              )
               
            )
          ],
        ),
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

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        //重新构建列表
        _words.insertAll(
            _words.length - 1,
            //每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}

class BookCardLayout extends StatelessWidget {
  const BookCardLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(15),
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
           child: Container(
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 33,
                  color: Colors.grey
                )
              ]
            ),
          ),
        ),
        Image.asset("assets/images/img1.jpg",width: 100,),
        Positioned(
          top:150,
          left:15,
          child: Text("藝利很重要"),
        ),
        Positioned(
          top:180,
          left:15,
          child: Wrap(children: <Widget>[
             Text("這是一本關於藝術重要性的書..."),
          ],)
        ),
        Positioned(
          top:50,
          right: 10,
          child: Column(
            children: <Widget>[
              IconButton(icon: Icon(
                Icons.favorite_border
              ),)
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 50,
            width:90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(29),),
              color: Colors.red,
            ),
            child: Center(
              child: Text("DM"),
            )
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 50,
            width:90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(29),),
              color: Colors.blue,
            ),
          ),
        )
      ],
      
    ),
                );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({
    Key key,
    @required List<String> words,
    @required int index,
  })  : _words = words,
        index = index,
        super(key: key);

  final List<String> _words;
  final int index;
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        margin: EdgeInsets.all(15),
        color: Colors.pink,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,

                width: 10,
                decoration: BoxDecoration(
                  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      offset: Offset(10,19)
                    )
                  ]
                ),
              ),
            ),
            Image.asset("assets/images/app_icon.png"),
           
          ],
        ),
      );
    
    
    
    
    
    
    Card(
      color: Colors.red,
      child:
        Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
               child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage('assets/images/app_icon.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            Positioned(
              child: ListTile(
                onTap: () {},
                title: Text(_words[this.index]),
                subtitle: Text("test"),
              ),
            ),
           
            Positioned(
              bottom: 10,
              right: 10,
              child: Icon(Icons.favorite),
            ),
          ],
        )
    );
  }
}
