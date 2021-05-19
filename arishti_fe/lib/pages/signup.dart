import 'dart:convert';

import 'package:arishti_fe/models/user.dart';
import 'package:arishti_fe/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future regUser() async {
    if (checkFields()) {
      print(user.email);
      print(user.password);
      var res = await http.post("http://192.168.43.113:8080/arishti/signup",
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            'name': user.name,
            'email': user.email,
            'password': user.password
          });
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Registeration succssfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 13.0);
        Navigator.of(context).pushNamed('/signin');
        print(res.body);
      } else {
        Fluttertoast.showToast(
            msg: "something went wrong try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 13.0);
        print('A network error occurred');
      }
    }
  }

  User user = User("", "", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Sign up'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.fingerprint,
                      size: 85.0,
                      color: Colors.deepPurpleAccent,
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) =>
                          value.isEmpty ? "Name can't be empty" : null,
                      onSaved: (value) => user.name = value,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Email is blank' : null,
                      onSaved: (value) => user.email = value,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          value.isEmpty ? 'Password is blank' : null,
                      onSaved: (value) => user.password = value,
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: MaterialButton(
                        minWidth: 500.0,
                        height: 40.0,
                        onPressed: regUser,
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          'Signup',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
