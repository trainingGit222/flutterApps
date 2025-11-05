import 'package:localnotification_withsaqlite/database/sqlite_file.dart';
import 'package:localnotification_withsaqlite/model/model_timedate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class SqliteServer {
static Database? _database;
static Future<Database?>  getDatabase()async{
  if(_database !=null){
    return _database;

  }
  _database = await intializeDatabase();
  return _database;
}
static intializeDatabase() async{
  String databasePath=await getDatabasesPath();
  String path=join(databasePath,'timeanddatedatabase.db');
  _database=await openDatabase(path,version:1,onCreate:_createdatabase);
  return _database;
}
static _createdatabase(Database db,int version)async{
  await db.execute(SqliteFile.createtable);
  print('========Database Created Successfully========');
}
static Future<int> insertData(Map<String,dynamic> map) async{
  Database? db=await getDatabase();
  int result=await db!.insert(SqliteFile.tableName,map);
  print('========Data Inserted Successfully========');
  return result;
}
/*
الفكرة هي أنك عندما تقرأ من قاعدة البيانات
فان البيانات تاتينا على شكل ماب 
لكن في الكود نحن نتعامل مع كائن اذن لابد من تحويل الماب الى كائن من نوع موديل تايم دايت
*/
static Future<List<ModelTimedate>> getData()async{
  Database? db=await getDatabase();
  final result=await db!.query(SqliteFile.tableName);
  return result.map((e)=>ModelTimedate.fromMap(e)).toList(); 

}

}















// import 'package:flutter/material.dart';
// import 'package:localnotification_withsaqlite/database/sqlite_file.dart';
// import 'package:localnotification_withsaqlite/model/model_timedate.dart';
// import 'package:path/path.dart';

// import 'package:sqflite/sqflite.dart';

// class SqliteServer {
//   static   Database? _database;
//  static Future<Database?> databaseasync()async{ 
//   if(_database !=null){
//     return _database;
//   }
//   _database=await intializeDatabase();
//   return _database;
  
//   }
//   static intializeDatabase() async {
//     String databasePath=await getDatabasesPath();
//     String path=join(databasePath,'timeanddatedatabase.db');
//     _database=await openDatabase(path,version: 1,onCreate:_oncreate);
//     return _database;
//   }
//   static _oncreate(Database db,int version)async{
//     await db.execute(SqliteFile.createtable);
//     print('========Database Created Successfully========');

//   }
//  static Future<int> insertData(ModelTimedate model)async{
//     Database? db=await databaseasync();
//     int result=await db!.insert(SqliteFile.tableName, model.toMap());
//     print('========Data Inserted Successfully========');
//     return result;
//   }
//   }