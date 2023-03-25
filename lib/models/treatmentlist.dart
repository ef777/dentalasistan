// To parse this JSON data, do
//
//     final treatmentlist = treatmentlistFromJson(jsonString);

import 'dart:convert';

import 'package:dental_asistanim/config.dart';
import 'package:http/http.dart' as http;

//https://demo.dentalasistanim.com/api/treatments?currencyId=TRY&priceListId=36&treatmentTypeId=1
class Treatmentlist {
  Treatmentlist({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<treatmentlist> data;
  static Future<List<treatmentlist>> treatmentlistgetir() async {
    try {
      var url =
          Uri.parse('https://demo.dentalasistanim.com/api/treatment-lists');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Config.token}'
        },
      );
      String responseString = response.body;
      print("bu cevap");
      print(responseString);
      print("bu token");
      print(Config.token);
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        print("bu hastalar");
        print(responseData['data']);
        print("treatmant geldi");

        List<treatmentlist> treatments = [];
        for (var jsonb in responseData['data']) {
          treatments.add(treatmentlist.fromJson(jsonb));
        }

        return treatments;
      } else {
        print("treantmentlist alıbnamadı");
        return [];
      }
    } catch (e) {
      print(e);
      print("treatment list hata");
      return [];
    }
  }

  factory Treatmentlist.fromRawJson(String str) =>
      Treatmentlist.fromJson(json.decode(str));

  factory Treatmentlist.fromJson(Map<String, dynamic> json) => Treatmentlist(
        success: json["success"],
        message: json["message"],
        data: List<treatmentlist>.from(
            json["data"].map((x) => treatmentlist.fromJson(x))),
      );
}

class treatmentlist {
  treatmentlist({
    required this.id,
    required this.name,
    required this.treatmentsCount,
  });

  final int id;
  final String name;
  final int treatmentsCount;

  factory treatmentlist.fromRawJson(String str) =>
      treatmentlist.fromJson(json.decode(str));

  factory treatmentlist.fromJson(Map<String, dynamic> json) => treatmentlist(
        id: json["id"],
        name: json["name"],
        treatmentsCount: json["treatments_count"],
      );
}
