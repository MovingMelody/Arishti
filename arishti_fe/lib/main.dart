import 'package:arishti_fe/pages/Navbar.dart';
import 'package:arishti_fe/pages/signin.dart';
import 'package:arishti_fe/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arishti',
      color: Colors.deepPurpleAccent,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Signin(),
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new Signin(),
        '/signup': (BuildContext context) => new Signup(),
        '/navbar': (BuildContext context) => new Navbar(
              username: null,
            ),
      }));
}
