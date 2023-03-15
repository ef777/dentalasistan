import 'dart:convert';

import 'config.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final randevutur = randevuturFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Randevutur {
  Randevutur({
    required this.data,
  });

  final List<randevugrup> data;

  factory Randevutur.fromRawJson(String str) =>
      Randevutur.fromJson(json.decode(str));

  factory Randevutur.fromJson(Map<String, dynamic> json) => Randevutur(
        data: List<randevugrup>.from(
            json["data"].map((x) => randevugrup.fromJson(x))),
      );

  class randevugrup {
    randevugrup({
      required this.id,
      required this.name,
      required this.className,
    });

    final int id;
    final String name;
    final String className;

    factory randevugrup.fromRawJson(String str) =>
        randevugrup.fromJson(json.decode(str));

    factory randevugrup.fromJson(Map<String, dynamic> json) => randevugrup(
          id: json["id"],
          name: json["name"],
          className: json["class_name"],
        );
  }
}



class RandevuModel {
  randevudurumlar() async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/appointment-statuses');
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
        print(responseData["data"]);
        return responseData["data"];
      } else {
        print("başarısız");
        print(responseData);
      }
    } catch (e) {
      print(e);
    }
  }
}
