import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'package:asset_db_fetch_1/modelClass/quranSuraComplete.dart';
import 'package:flutter/services.dart';
import 'package:large_file_copy/large_file_copy.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuranSurahCompleteDataSource {
  static Database _db;
/*
  QuranSurahCompleteDataSource._();
  static final QuranSurahCompleteDataSource quranDB = QuranSurahCompleteDataSource._();*/

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var path;

    if (Platform.isIOS) {
      var databasesPath = await getDatabasesPath();
      path = join(databasesPath, "quran.db");
    }

    if(Platform.isAndroid){
      path = await LargeFileCopy("quran.db").copyLargeFile;
    }

    Database db = await openDatabase(path, readOnly: true);

    return db;
  }

  Future<List<QuranSuraComplete>> getCompleteSura(String surahid) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("select * from quran_verses where quran_verses.sura_id = ${surahid}");
    print(list.length);
    List<QuranSuraComplete> surahcomplete = new List();
    for (int i = 0; i < list.length; i++) {
      surahcomplete.add(new QuranSuraComplete(
        list[i]["sura_id"],
        list[i]["arabic_uthmanic"],
        list[i]["bn_muhi"],
        list[i]["trans"],
        list[i]["en_sahih"],
        list[i]["verse_id"],
      ));
    }
    return surahcomplete;
  }





}
