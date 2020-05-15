import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onlinemandi_admin/customers.dart';
import 'package:onlinemandi_admin/homepage.dart';
import 'package:onlinemandi_admin/loginpage.dart';
import 'package:onlinemandi_admin/methods.dart';
import 'package:onlinemandi_admin/shopkeepers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Online Mandi Admin",
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/customers': (context) => AllCustomers(),
        '/shopkeepers': (context) => AllShopKeeper(),
      },
      theme: ThemeData(
          fontFamily: 'Josefin',
          primaryColor: Colors.deepPurple,
          accentColor: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMethods _methods = FirebaseMethods();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      if (await _methods.isLogged()) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Online Mandi Admin",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 40.0,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
