// To parse this JSON data, do
//
//     final randevustatus = randevustatusFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';

class Randevustatus {
  Randevustatus({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<statusmodel> data;

  static Future<List<statusmodel>> statusgetir() async {
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

      if (response.statusCode == 200) {
        print("tarihli fonk başarılı");
        String responseString = response.body;

        Map<String, dynamic> responseData = json.decode(responseString);
        print("tarihli fonk başarılı2");

        Randevustatus resp = (Randevustatus.fromJson(responseData));
        print("tarihli fonk başarılı3");

        var sonuc = resp.data;
        print(response.body);
        print("başarılı");
        return sonuc;
      } else {
        print("tarhili fonk çek başarısız");
        print(response);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  factory Randevustatus.fromRawJson(String str) =>
      Randevustatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Randevustatus.fromJson(Map<String, dynamic> json) => Randevustatus(
        success: json["success"],
        message: json["message"],
        data: List<statusmodel>.from(
            json["data"].map((x) => statusmodel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class statusmodel {
  statusmodel({
    required this.status,
    required this.name,
  });

  final String status;
  final String name;

  factory statusmodel.fromRawJson(String str) =>
      statusmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory statusmodel.fromJson(Map<String, dynamic> json) => statusmodel(
        status: json["status"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "name": name,
      };
}
