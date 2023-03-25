// To parse this JSON data, do
//
//     final randevudurum = randevudurumFromJson(jsonString);

import 'package:http/http.dart' as http;

import '../config.dart';

import 'dart:convert';

class Randevudurum {
  Randevudurum({
    this.success,
    this.message,
    this.data,
  });
  static Future<List<rdurum>> randevudurumlar() async {
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
        print("doktorliste");
        List<rdurum> rmodels = [];
        for (var jsonc in responseData['data']) {
          rmodels.add(rdurum.fromJson(jsonc));
        }
        print(responseData["data"]);
        return rmodels;
      } else {
        print("başarısız");
        print(responseData);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  final bool? success;
  final String? message;
  final List<rdurum>? data;

  factory Randevudurum.fromRawJson(String str) =>
      Randevudurum.fromJson(json.decode(str));

  factory Randevudurum.fromJson(Map<String, dynamic> json) => Randevudurum(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<rdurum>.from(json["data"]!.map((x) => rdurum.fromJson(x))),
      );
}

class rdurum {
  rdurum({
    this.status,
    this.name,
  });

  final String? status;
  final String? name;

  factory rdurum.fromRawJson(String str) => rdurum.fromJson(json.decode(str));

  factory rdurum.fromJson(Map<String, dynamic> json) => rdurum(
        status: json["status"],
        name: json["name"],
      );
}
