// @dart=2.9

import 'dart:convert';
import 'package:crypto/Models/cryptoModel.dart';
import 'package:crypto/screens/FullScreen.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Datum> cryptoList;
  bool first = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      initialize();
    });
    await Future.delayed(Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }

  void initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = prefs.getString("key");
    var parsed = json.decode(temp) as List<dynamic>;
    var cryptos = parsed.map((i) => Datum.fromJson(i)).toList();
    if (cryptos != null) {
      setState(() {
        cryptoList = cryptos;
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      initialize();
    }

    return Scaffold(
      body: cryptoList != null
          ? cryptoList.length == 0
              ? new Center(
                  child: new Text(
                    "Nothing Found !",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : Scrollbar(
                  controller: ScrollController(),
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: cryptoList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: new Material(
                            elevation: 8.0,
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(8.0)),
                            child: new GestureDetector(
                              onTap: () {
                                try {
                                  //wait until build is complete
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => new FullScreen(
                                        cryptoData: i,
                                        temp: cryptoList,
                                        isfav: true,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  //if exception occured then rebuild the widget
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "   " +
                                          cryptoList[i].name +
                                          "  (" +
                                          cryptoList[i].symbol +
                                          ")  ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Architect',
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
          : new Center(
              child: new Text(
                "Nothing Found !",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
    );
  }
}
