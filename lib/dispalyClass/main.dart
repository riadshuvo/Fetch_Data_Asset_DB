import 'package:asset_db_fetch_1/dispalyClass/completeSura.dart';
import 'package:asset_db_fetch_1/modelClass/suraName.dart';
import 'package:flutter/material.dart';
import 'package:asset_db_fetch_1/databaseSection/suraList.dart';

void main() async {

  runApp(new MaterialApp(
    title: "fetch_db",
    home: SuraNameList(),
  ));
}

class SuraNameList extends StatefulWidget {
  @override
  _SuraNameListState createState() => _SuraNameListState();
}

class _SuraNameListState extends State<SuraNameList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data"),
        centerTitle: true,
      ),
      body: new FutureBuilder<List<QuranSurahName>>(
          future: QuranSuraNameDataSource.quranDB.getSuraName(),
          builder: (context, AsyncSnapshot<List<QuranSurahName>> snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var suraName = snapshot.data[index].suraname_bangla;
                    int sura_id = snapshot.data[index].suraname_id;
                    return Card(
                      elevation: 1.0,
                      child: new ListTile(
                        onTap: () => Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => CompleteSura(
                                  suraName, sura_id
                            ))),

                        title: new Text(
                            suraName,
                          style: TextStyle(
                              color:
                                   Colors.black),
                        ),
                        subtitle: new Text(
                          snapshot.data[index].suraname_arabic,
                          style: TextStyle(
                              color: Colors.black),
                        ),
                      ),
                    );
                  });
            } else
              return Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ));
          }),
    );
  }

  void completeSuraClass(String suraname_bangla) {

  }

}
