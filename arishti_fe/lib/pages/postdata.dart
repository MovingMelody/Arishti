import 'package:arishti_fe/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Postdata extends StatefulWidget {
  Postdata({Key key}) : super(key: key);

  @override
  _PostdataState createState() => _PostdataState();
}

class _PostdataState extends State<Postdata> {
  TextEditingController idcontroller = TextEditingController();
  TextEditingController useridcontroller = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  String dataHolder = 'Click button to post the data';
// int userId, int id, String title, String body
  Future<String> postData(String userId, String title, String body) async {
    setState(() {
      dataHolder = 'Posting Data.......';
    });
    var res = await http.post('https://jsonplaceholder.typicode.com/posts/',
        body: {"userId": userId, "title": title, "body": body});

    print(res.statusCode);
    if (res.statusCode == 201) {
      setState(() {
        dataHolder = res.body;
      });
      // return apidataFromJson(res.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Column(
            children: [
              TextFormField(
                controller: idcontroller,
                decoration: InputDecoration(
                  hintText: 'Id',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: useridcontroller,
                decoration: InputDecoration(
                  hintText: 'userId',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'body',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                controller: titlecontroller,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: bodycontroller,
                decoration: InputDecoration(
                  hintText: 'title',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              // Text("data"),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  postData(useridcontroller.text, bodycontroller.text,
                      titlecontroller.text);
                },
                child: Text("Post Request"),
              ),
              Text('$dataHolder'),
            ],
          )),
        ),
      ),
    );
  }
}
