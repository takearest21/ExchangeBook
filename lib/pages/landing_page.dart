import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:bookSwap/constants.dart';
import '../models/testing_data.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const loadingTag = "##loading##"; 
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

  void addToFavouriteList(){

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Scaffold(
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
                itemCount: TESTING_DATA.length,
                itemBuilder: (context, index) {
                  //如果到了表尾
                  if (_words[index] == loadingTag) {
                    //不足100条，继续获取数据
                    if (_words.length - 1 < 5) {
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
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 0)).then((e) {
      setState(() {
        //重新构建列表
        _words.insertAll(
            _words.length - 1,
            //每次生成20个单词
            generateWordPairs().take(10).map((e) => e.asPascalCase).toList());
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
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.only(bottomRight: Radius.circular(29),),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 33,
                  color: Colors.white
                )
              ]
            ),
          ),
        ),
        Image.asset("assets/images/img2.jpg",width: 100,),
        Positioned(
          top:150,
          left:15,
          child: Text("動物農莊"),
        ),
        Positioned(
          top:180,
          child: Container(
            child: 
             Text("《動物農場》借動物的遭際\n諷刺獨裁政治的腐敗，揭露\n極權統治的殘暴，是一部警\n世寓言。"),
         
            )
        ),
        Positioned(
          top:50,
          right: 10,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  print("click");
                },
                child: IconButton(
                  onPressed: (){
                    
                  },
                  icon: Icon(
                Icons.favorite_border
              ),)
              )
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(29),),
              color: Colors.black,
            ),
            child: Center(
              child: Text("DM", style: TextStyle(fontSize: 15, color: Colors.white),),
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
              color: Colors.yellow,
            ),
            child: Center(
              child: Text("Detail", style: TextStyle(fontSize: 15, color: Colors.black),),
            )
          ),
        )
      ],
      
    ),
                );
  }
}

class BookCard extends StatelessWidget {
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
  }
}
