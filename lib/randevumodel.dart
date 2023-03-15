/* import 'dart:convert';

import 'config.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final randevutur = randevuturFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Randevutur {
  Randevutur({
    required this.success,
    required this.message,
    required this.data,
  });

  randevuturugrup() async {
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

      if (response.statusCode == 200) {
        print("başarılı");
        print("randevutur");

        return response;
      } else {
        print("başarısız");
        return response;
      }
    } catch (e) {
      print("hata");
      print(e);
    }
  }

  final bool success;
  final String message;
  final List<Datum> data;

  factory Randevutur.fromRawJson(String str) =>
      Randevutur.fromJson(json.decode(str));

  factory Randevutur.fromJson(Map<String, dynamic> json) => Randevutur(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.className,
  });

  final int id;
  final String name;
  final String className;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        className: json["class_name"],
      );
}/*  */

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
 */