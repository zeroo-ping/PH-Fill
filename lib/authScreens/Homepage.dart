import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_widgets/sign_in.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        //Color.fromRGBO(13, 132, 155, 1),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset('images/icon.png'),
              //FlutterLogo(size: 150),
            ),
            Center(
              child: SizedBox(height: 20),
            ),
            _signInButton(
              3,
              'Sign in with Google',
              () {
                signInWithGoogle().then((result) {
                  if (result != null) {
                    Navigator.pushNamed(context, '2');
                  }
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'OR',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            _signInButton(
              4,
              'Sign in with Phone.',
              () {
                Navigator.pushNamed(context, '3');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _signInButton(int y, String z, Function onTap) {
  return OutlineButton(
    splashColor: Colors.white,
    onPressed: onTap,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.red,
            backgroundImage: AssetImage('images/$y.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              z,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
