import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableBookInfo = "bookInfo";
final String columnId = '_id';
final String columnBookName = "contactBookName";
final String columnBookIntro = "contactBookIntro";
final String columnStartDate = "startDate";
final String columnBookNews = "content";
final String columnRemark = "remark";
final String columnMember = "member";
final String columnStatus = "status";
final String columnImageListString = "imageListString";

class BookInfo {
  int id;
  // Map<int, String> orderType = {
  //   0: "Foods",
  //   1: "Stock",
  // };
  String orderType;
  String contactBookName;
  String contactBookIntro;
  String startDate;
  String deliveryDate;
  String content;
  String remark;
  String member;
  // Map<int, String> status = {
  //   0: "ON PROGRESS",
  //   1: "SUCCESS",
  //   2: "FAIL"
  // };
  String status;
  String imageListString;
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId : id,
      columnBookName: contactBookName,
      columnBookIntro: contactBookIntro,
      columnStartDate: startDate,
      columnBookNews:content,
      columnRemark:remark,
      columnMember:member,
      columnStatus:status,
      columnImageListString:imageListString,

    };    
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  BookInfo();

  BookInfo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    contactBookName = map[columnBookName];
    contactBookIntro = map[columnBookIntro];
    startDate = map[columnStartDate];
    content = map[columnBookNews];
    remark = map[columnRemark];
    member = map[columnMember];
    status = map[columnStatus];
    imageListString = map[columnImageListString];
     
  }         
  
}


// class OrderType {
//   final String ordertype;

//     OrderType({
//     this.ordertype="Foods",
//   });
// }

class BookInfoSqlite {
  Database db;

  openSqlite() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableBookInfo (
            $columnId  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            $columnBookName TEXT, 
            $columnBookIntro TEXT, 
            $columnStartDate TEXT, 
            $columnBookNews TEXT,
            $columnRemark TEXT,
            $columnMember TEXT,
            $columnStatus TEXT,
            $columnImageListString TEXT)
          ''');
    });
  }

  Future deleteTable() async{
    return await db.delete(tableBookInfo);
  }

  Future<BookInfo> insert(BookInfo book) async {
    book.id = await db.insert(tableBookInfo, book.toMap());
    return book;
  }

    Future<void> insertBook(BookInfo bookInfo) async {
    //引用資料庫

    // 插入狗狗資料庫語法
    await db.insert(
      'bookInfo',
      bookInfo.toMap(),
      //當資料發生衝突，定義將會採用 replace 覆蓋之前的資料 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<BookInfo>> queryAll() async {
    List<Map> maps = await db.rawQuery("select * from $tableBookInfo order by _id Desc limit 10");  

    if (maps == null || maps.length == 0) {
      return null;
    }

    List<BookInfo> books = [];
    for (int i = 0; i < maps.length; i++) {
      books.add(BookInfo.fromMap(maps[i]));
    }
    return books;
  }

  Future<List<BookInfo>> getBook(String value) async {
    List<Map> maps = await db.rawQuery("select * from $tableBookInfo where $columnBookIntro Like '%$value%' order by _id Desc");  
    List<BookInfo> books = [];
    for (int i = 0; i < maps.length; i++) {
      books.add(BookInfo.fromMap(maps[i]));
    }
    return books;
  }

    Future<List<BookInfo>> queryNext(int limit , int offSet) async {

    List<Map> maps = await db.rawQuery("select * from $tableBookInfo order by _id Desc Limit $limit OFFSET $offSet");  
    if (maps == null || maps.length == 0) {
      return null;
    }

    List<BookInfo> books = [];
    for (int i = 0; i < maps.length; i++) {
      books.add(BookInfo.fromMap(maps[i]));
    }
    return books;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableBookInfo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(BookInfo book) async {   
    try {
     return await db.update(tableBookInfo, book.toMap(),
        where: '$columnId = ?', whereArgs: [book.id]);
    }catch(e){
        print(e);
    }
    
    return 0;
  }

  Future<int> softDelete(BookInfo book) async {   
    try {
     return await db.update(tableBookInfo, book.toMap(),
        where: '$columnId = ?', whereArgs: [book.id]);
    }catch(e){
        print(e);
    }
    
    return 0;
  }

  close() async {
    await db.close();
  }
}