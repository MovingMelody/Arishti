class Apidata {
  final int id;
  final String title;
  final String body;

  Apidata({this.id, this.title, this.body});

  factory Apidata.fromJson(Map<String, dynamic> json) {
    return Apidata(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
