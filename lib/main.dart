import 'package:flutter/material.dart';
import 'package:hacakthon_app/auth_widgets/phone.dart';
import 'package:hacakthon_app/screens/My_Request.dart';

import './screens/request_page.dart';
import './authScreens/Homepage.dart';
import './auth_widgets/Phone_verification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PH Fill',
      color: Color.fromRGBO(13, 132, 155, 1),
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(13, 132, 155, 1),
      ),
      initialRoute: '1',
      routes: {
        '1': (context) => Homepage(),
        '2': (context) => RequestPage(),
        '3': (context) => LoginScreen(),
        '4': (context) => Phone(),
        '5': (context) => MyRequest(),
      },
    );
  }
}
