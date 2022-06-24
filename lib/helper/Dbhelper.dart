import 'dart:io';

import 'package:millchargesystem/models/credit/single_credit_model.dart';
import 'package:millchargesystem/models/generalinfo/local_general_info_model.dart';
import 'package:millchargesystem/models/notices/single_note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'millcharge.db');
    return await openDatabase(path,
        version: 4, onCreate: _onCreate, onUpgrade: onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE generalInfo(
    gid INTEGER PRIMARY KEY,
    name TEXT,
    mytotalcredit TEXT,
    mytotaldebit TEXT,
    monthtotaldebit TEXT,
    monthtotalcredit TEXT,
    totalmills TEXT,
    mytotalmills TEXT,
    cashinhand INTEGER,
    currentmillcharge INTEGER,
    mytotalcost INTEGER,
    back INTEGER, 
    addmore INTEGER
    )''');

    await db.execute('''CREATE TABLE MonthCredits(
    cid INTEGER PRIMARY KEY,
    id TEXT,
    creditDate TEXT,
    creditAmount TEXT,
    creditDescription TEXT,
    notes TEXT,
    creditMonth TEXT,
    creditYear TEXT,
    creditedBy TEXT,
    creditImage INTEGER,
    creditHostel_id INTEGER,
    createdAt TEXT, 
    updatedAt TEXT
    )''');



    await db.execute('''CREATE TABLE Notes(
    noteid INTEGER PRIMARY KEY,
    id TEXT,
    notice_description TEXT,
    notice_date TEXT,
    notice_month TEXT,
    notice_year TEXT,
    notice_status TEXT,
    notedBy TEXT,
    note_hostel_id TEXT,
    name TEXT,
    hostel_name TEXT,
    createdAt INTEGER, 
    updatedAt INTEGER
    )''');

  }

  Future onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      print("onupgrade called");
    }
  }

  //general info...

  Future<int> addLocalGeneralInfo(LocalGeneralInfoModel localGeneralInfoModel) async{
    Database db = await instance.database;
    return await db.insert('generalInfo',localGeneralInfoModel.toJson());
  }






  Future<dynamic> deleteLocalGeneralInfo() async {
    Database db = await instance.database;
    var a = db.execute("delete from generalInfo");
    print("delete result: $a");
    return a;
  }

  Future<List<LocalGeneralInfoModel>> getLocalGeneralInfo() async {
    Database db = await instance.database;
    var retrivedgeneralinfo = await db.query('generalInfo', orderBy: 'gid');
    List<LocalGeneralInfoModel> infoList = retrivedgeneralinfo.isNotEmpty
        ? retrivedgeneralinfo.map((c) => LocalGeneralInfoModel.fromJson(c)).toList()
        : [];
    int sizeofs = infoList.length - 1;
    for (int i = 0; i <= sizeofs; i++) {
      print("database orderlist status is : " +
          infoList[i].monthtotaldebit +
          "and order number " +
          infoList[i].monthtotalcredit);
    }
    return infoList;
  }

  //end of general info


  //credit operations
  Future<int> addACredit(SingleCreditModel singleCreditModel) async{
    Database db = await instance.database;
    return await db.insert('MonthCredits',singleCreditModel.toJson());
  }

  Future<dynamic> deleteCredits() async {
    Database db = await instance.database;
    var a = db.execute("delete from MonthCredits");
    print("delete result from monthcredit table : $a");
    return a;
  }


  Future<List<SingleCreditModel>> getLocalCredits() async {
    Database db = await instance.database;
    var retrivedCreditInfo = await db.query('MonthCredits', orderBy: 'cid');
    List<SingleCreditModel> creditList = retrivedCreditInfo.isNotEmpty
        ? retrivedCreditInfo.map((c) => SingleCreditModel.fromJson(c)).toList()
        : [];
    int sizeofs = creditList.length - 1;
    for (int i = 0; i <= sizeofs; i++) {
      print("database creditlist  is : " +
          creditList[i].creditAmount );
    }
    return creditList;
  }



  //for notes
  Future<int> addSingleNote(SingleNoteModel singleNoteModel) async{
    Database db = await instance.database;
    return await db.insert('Notes',singleNoteModel.toJson());
  }

  Future<List<SingleNoteModel>> getAllNotes() async {
    Database db = await instance.database;
    var retrivedNoteInfo = await db.query('Notes', orderBy: 'noteid');
    List<SingleNoteModel> noteList = retrivedNoteInfo.isNotEmpty
        ? retrivedNoteInfo.map((c) => SingleNoteModel.fromJson(c)).toList()
        : [];
    int sizeofs = noteList.length - 1;
    for (int i = 0; i <= sizeofs; i++) {
      print("database notelist  is : " +
          noteList[i].noticeDescription );
    }
    return noteList;
  }


  Future<dynamic> deleteNotes() async {
    Database db = await instance.database;
    var a = db.execute("delete from Notes");
    print("delete result from Notes table : $a");
    return a;
  }

}