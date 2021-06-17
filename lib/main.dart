// @dart=2.9

import 'package:crypto/Service/api.dart';
import 'package:crypto/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Api>(create: (_) => Api()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        title: "Crypto",
        initialRoute: '/home',
        routes: {
          '/home': (context) => MyHomePage(),
        },
      ),
    );
  }
}
