import 'dart:convert';

import 'config.dart';
import 'package:http/http.dart' as http;

class HastaModel {
  final int id;
  final String name;
  final String phone;
  final String? avatar;
  final String? identity_number;
  final String? avatar_path;
  final dynamic? information;
  static Future<List<HastaModel>> hastagetir() async {
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/patients');
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
        print(responseData['data']['data']);
        print("hastalar tamam");

        List<HastaModel> HastaModels = [];
        for (var HastaModelJson in responseData['data']['data']) {
          HastaModels.add(HastaModel.fromJson(HastaModelJson));
        }

        return HastaModels;
      } else {
        print("hasta alınamado");
        return [];
      }
    } catch (e) {
      print(e);
      print("hasta hata");
      return [];
    }
  }

  HastaModel(
      {required this.id,
      required this.name,
      required this.phone,
      this.avatar,
      this.avatar_path,
      this.identity_number,
      this.information});

  factory HastaModel.fromJson(Map<String, dynamic> json) {
    return HastaModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      avatar: json['avatar'],
      avatar_path: json['avatar_path'],
      identity_number: json['identity_number'],
      information: json['information'],
    );
  }
}
