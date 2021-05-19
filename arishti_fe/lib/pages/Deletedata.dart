import 'dart:async';

import 'package:arishti_fe/models/data.dart';
import 'package:arishti_fe/services/api-services.dart';
import 'package:flutter/material.dart';


class Deletedata extends StatefulWidget {
  Deletedata({Key key}) : super(key: key);

  @override
  _DeletedataState createState() {
    return _DeletedataState();
  }
}

class _DeletedataState extends State<Deletedata> {
  Future<Apidata> _futureApidata;

  @override
  void initState() {
    super.initState();
    _futureApidata = fetchDataOnLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: FutureBuilder<Apidata>(
            future: _futureApidata,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Title : ${snapshot.data?.title ?? 'Deleted'}'),
                      Text('Body : ${snapshot.data?.body ?? ''}'),
                      ElevatedButton(
                        child: Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureApidata = deleteApiData();
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
