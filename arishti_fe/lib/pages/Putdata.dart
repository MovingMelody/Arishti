import 'dart:async';
import 'package:arishti_fe/models/data.dart';
import 'package:arishti_fe/services/api-services.dart';
import 'package:flutter/material.dart';

class Putdata extends StatefulWidget {
  Putdata({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Putdata> {
  final TextEditingController _controller = TextEditingController();
  Future<Apidata> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchDataOnLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Apidata>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data.title),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Enter Title to update'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureAlbum = updateAlbum(_controller.text);
                        });
                      },
                      child: Text('Update Data / Put Data'),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
