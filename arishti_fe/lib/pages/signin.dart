import 'package:arishti_fe/models/user.dart';
import 'package:arishti_fe/pages/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formkey = GlobalKey<FormState>();
  User user = User("", "", "");

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future loginUser() async {
    // TODO: login here
    if (checkFields()) {
      print(user.email);
      print(user.password);
      var res = await http.post("http://192.168.43.113:8080/arishti/signin",
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            'email': user.email,
            'password': user.password
          });
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Login succssful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 13.0);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Navbar(
                username: user.email,
              ),
            ));
        print(res.body);
      } else {
        Fluttertoast.showToast(
            msg: "User doesn't exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 13.0);
        print('An error occurred');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.fingerprint,
                      size: 80.0,
                      color: Colors.deepPurpleAccent,
                    ),
                    SizedBox(height: 29.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail),
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
                        prefixIcon: Icon(Icons.vpn_key),
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
                        onPressed: loginUser,
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blueAccent),
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
