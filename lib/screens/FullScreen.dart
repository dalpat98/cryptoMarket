// @dart=2.9

import 'dart:convert';
import 'package:crypto/Models/cryptoModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreen extends StatefulWidget {
  final int cryptoData;
  final List<Datum> temp;
  final bool isfav;

  const FullScreen({Key key, this.cryptoData, this.temp, this.isfav})
      : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.temp[widget.cryptoData].name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: 'Architect',
          ),
        ),
        elevation: 0.7,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID : " + widget.temp[widget.cryptoData].id.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name : " + widget.temp[widget.cryptoData].name.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Symbol : " + widget.temp[widget.cryptoData].symbol.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Slug : " + widget.temp[widget.cryptoData].slug.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rank : " + widget.temp[widget.cryptoData].rank.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "First HD : " +
                    widget.temp[widget.cryptoData].firstHistoricalData
                        .toString()
                        .split(' ')[0],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Last HD : " +
                    widget.temp[widget.cryptoData].lastHistoricalData
                        .toString()
                        .split(' ')[0],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Platform : " +
                    widget.temp[widget.cryptoData].platform.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Architect',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.favorite),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(5),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
                  ),
                  label: Text(
                    widget.isfav == true
                        ? 'Remove From Favourites'
                        : 'Add to Favourite',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    widget.isfav == false
                        ? _addtofavorite(widget.temp[widget.cryptoData])
                        : _removefromfavorite(widget.temp[widget.cryptoData]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Datum> cryptoList;
  Future<bool> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = prefs.getString("key");
    var parsed = json.decode(temp) as List<dynamic>;
    var cryptos = parsed.map((i) => Datum.fromJson(i)).toList();

    if (cryptos != null) {
      setState(() {
        cryptoList = cryptos;
      });
      return true;
    } else
      return false;
  }

  Future<bool> _addtofavorite(Datum id) async {
    bool k = await initialize();
    progress(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int a = 0;
    if (cryptoList == null) cryptoList = [];
    for (Datum i in cryptoList) {
      if (i.id == id.id)
        break;
      else {
        ++a;
        continue;
      }
    }
    if (a == cryptoList.length) {
      cryptoList.add(id);
    }
    progress(false);
    String data = json.encode(cryptoList);
    return await prefs.setString("key", data);
  }

  Future<bool> _removefromfavorite(Datum id) async {
    bool k = await initialize();
    progress(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cryptoList.removeWhere((element) => element.id == id.id);
    progress(false);
    String data = json.encode(cryptoList);
    return await prefs.setString("key", data);
  }

  void progress(bool i) {
    if (i) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(10),
            children: <Widget>[
              Container(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(10),
            children: <Widget>[
              Container(
                child: Center(
                  child: Icon(
                    Icons.done,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }
}
