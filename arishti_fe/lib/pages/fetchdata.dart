import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Fetchdata extends StatefulWidget {
  Fetchdata({Key key}) : super(key: key);

  @override
  _FetchdataState createState() => _FetchdataState();
}

class _FetchdataState extends State<Fetchdata> {
  String dataHolder = 'Click button to get the data';
  Future<String> getData() async {
    setState(() {
      dataHolder = 'Loading.......';
    });
    var res = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/posts/'),
        headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      print(res.body);
      setState(() {
        dataHolder = res.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Column(
            children: [
              // Text("data"),
              RaisedButton(
                onPressed: getData,
                child: Text("Get Request"),
              ),
              Text('$dataHolder'),
            ],
          )),
        ),
      ),
    );
  }
}
