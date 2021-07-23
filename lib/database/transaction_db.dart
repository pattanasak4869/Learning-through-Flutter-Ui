import 'dart:io';
import 'package:apsfinancial/models/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB{
  // บริการเกี่ยวกับฐานข้อมูล
  String dbName;  //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถูกสร้างไว้แล้ว => เปิด
  TransactionDB({required this.dbName});

  Future <Database> openDatabase() async{
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path,dbName);
    // สร้าง databaase
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async{
      // ฐานข้อมูล => Store
      // transaction.db => expense
      var db = await this.openDatabase();
      var store = intMapStoreFactory.store("expense");

      //json
      var keyID = store.add(db, {
        "title": statement.title,
        "amount": statement.amount,
        "date": statement.date.toIso8601String()
      });
      db.close();
      return keyID;
  }

  //ดึงข้อมูล
  loadAllData() async{
      // ฐานข้อมูล => Store
      // transaction.db => expense
      var db = await this.openDatabase();
      var store = intMapStoreFactory.store("expense");
      var snapshot = store.find(db);
      print(snapshot);
      return true;
  }
}