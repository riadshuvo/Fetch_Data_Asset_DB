import 'dart:async';
import 'package:asset_db_fetch_1/modelClass/suraName.dart';
import 'package:large_file_copy/large_file_copy.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class QuranSuraNameDataSource {
  static String SURAH_ID = "id";
  static String SURAH_NAMEBANGLA = "name";
  static String SURAH_NAMEARABIC = "name_ar";

  static Database _db;
  QuranSuraNameDataSource._();
  static final QuranSuraNameDataSource quranDB = QuranSuraNameDataSource._();

  Future<Database> get db async {
    if(_db != null) return _db;
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
  /*
  * field 1 , id
  * field 2 , sura num
  * field 3, sura arabic
  * field 4, sura bangla
  * field 5 ayah number
  * fiedl 6 makkhi madani
  *
  * */
  Future<List<QuranSurahName>> getSuraName() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM sura');
    List<QuranSurahName> suranames = new List();
    for(int i = 0;i< list.length;i++){
      suranames.add(new QuranSurahName(list[i][SURAH_ID], list[i][SURAH_NAMEBANGLA], list[i][SURAH_NAMEARABIC],));
    }
    return suranames;

  }
}
