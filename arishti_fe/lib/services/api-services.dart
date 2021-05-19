import 'dart:convert';

import 'package:arishti_fe/models/data.dart';
import 'package:http/http.dart' as http;

Future<Apidata> fetchDataOnLoad() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
  );

  if (response.statusCode == 200) {
    return Apidata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('no data found');
  }
}


Future<Apidata> deleteApiData() async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/2'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Apidata.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete api data.');
  }
}




Future<Apidata> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
   
    return Apidata.fromJson(jsonDecode(response.body));
  } else {
   
    throw Exception('Failed to update data.');
  }
}
