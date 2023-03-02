import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url1);

  final String url1;

  Future getData() async {
    var url = Uri.parse(url1);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print('not working');
    }
  }
}
