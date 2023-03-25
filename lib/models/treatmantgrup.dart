import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';

class randevugrupmodel {
  int? id;
  String? name;
  String? class_name;
  static Future<List<randevugrupmodel>> randevuturugrup() async {
    try {
      var url =
          Uri.parse('https://demo.dentalasistanim.com/api/treatment-groups');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Config.token}'
        },
      );
      String responseString = response.body;
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        print("başarılı");
        print("randevutur");
        print(responseData["data"]);
        List<randevugrupmodel> grupmodels = [];
        for (var randevugrupmodeljson in responseData['data']) {
          grupmodels.add(randevugrupmodel.fromJson(randevugrupmodeljson));
        }
        print("başarısız");
        print(responseData);
        return grupmodels;
      } else {
        return [];
      }
    } catch (e) {
      return [];
      print(e);
    }
  }

  randevugrupmodel({
    required this.id,
    required this.name,
    required this.class_name,
  });
  factory randevugrupmodel.fromJson(Map<String, dynamic> json) {
    return randevugrupmodel(
      id: json['id'],
      name: json['name'],
      class_name: json['class_name'],
    );
  }
}
