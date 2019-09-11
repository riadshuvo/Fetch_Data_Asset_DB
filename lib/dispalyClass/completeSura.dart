import 'package:asset_db_fetch_1/databaseSection/QuranSurahCompleteDataSource.dart';
import 'package:asset_db_fetch_1/modelClass/quranSuraComplete.dart';
import 'package:flutter/material.dart';

class CompleteSura extends StatefulWidget {
  String tittle;
  int sura_id;

  CompleteSura(this.tittle, this.sura_id);

  @override
  _CompleteSuraState createState() => _CompleteSuraState();
}

class _CompleteSuraState extends State<CompleteSura> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.tittle),
      ),
      body:new FutureBuilder<List<QuranSuraComplete>>(
          future: QuranSurahCompleteDataSource().getCompleteSura(widget.sura_id.toString()),
          builder: (context, AsyncSnapshot<List<QuranSuraComplete>> snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    String arabic_uthmanic = snapshot.data[index].arabic_uthmanic;
                    String bn_muhi = snapshot.data[index].bn_muhi;
                    return Card(
                      elevation: 1.0,
                      child: new ListTile(
                        title: new Text(
                          arabic_uthmanic,
                          style: TextStyle(
                              color:
                              Colors.black),
                        ),
                        subtitle: new Text(
                          bn_muhi,
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
          }) ,

    );
  }
}
