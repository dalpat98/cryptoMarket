// @dart=2.9

import 'package:crypto/Service/api.dart';
import 'package:crypto/screens/FullScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CryptoScreen extends StatefulWidget {
  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  bool first = true;
  Api obj;
  bool loading = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      loading = true;
      getData(listen: false);
    });
    await Future.delayed(Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }

  void getData({listen: true}) async {
    obj = Provider.of<Api>(context, listen: listen);
    bool l = await obj.getdata();
    if (l) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      getData();
    }
    return Scaffold(
      body: loading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : Scrollbar(
              controller: ScrollController(),
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: obj.cryptoModel.data.length,
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
                                    temp: obj.cryptoModel.data,
                                    isfav: false,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "   " +
                                      obj.cryptoModel.data[i].name +
                                      "  (" +
                                      obj.cryptoModel.data[i].symbol +
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
            ),
    );
  }
}
