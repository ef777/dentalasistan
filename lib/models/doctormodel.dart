import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';

class doktorgetmodel {
  dynamic? id;
  dynamic? role_id;
  dynamic? tenant_id;
  dynamic? name;
  dynamic? email;
  dynamic? phone;
  dynamic? commission_rate;
  dynamic? email_verified_at;
  dynamic? avatar;
  dynamic? status;
  dynamic? opening_time;
  dynamic? closing_time;
  dynamic? created_at;
  dynamic? updated_at;
  dynamic? deleted_at;

  static Future<List<doktorgetmodel>> doktorliste() async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/branches/${Config.subeid}/doctors');
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
        List<doktorgetmodel> docmodels = [];
        for (var doktorgetmodeljson in responseData['data']) {
          docmodels.add(doktorgetmodel.fromJson(doktorgetmodeljson));
        }
        print(responseData["data"]);
        return docmodels;
      } else {
        print("başarısız");
        print(responseData);
        return [];
      }
    } catch (e) {
      print("hata");
      print(e);
      return [];
    }
  }

  doktorgetmodel(
      {required this.id,
      required this.name,
      this.phone,
      this.tenant_id,
      this.avatar,
      this.commission_rate,
      this.email,
      this.role_id,
      this.closing_time,
      this.opening_time,
      this.email_verified_at,
      this.status,
      this.created_at,
      this.deleted_at,
      this.updated_at});
  // [{id: 3, role_id: 4, tenant_id: 1, name: Doktor 1, email: doktor@onderakkaya.com, phone: 05413317717, commission_rate: 10, email_verified_at: null, avatar: null, status: 1, opening_time: null, closing_time: null, created_at: 2023-02-10T18:39:58.000000Z, updated_at: 2023-02-10T18:39:58.000000Z, deleted_at: null}]
  factory doktorgetmodel.fromJson(Map<String, dynamic> json) {
    return doktorgetmodel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      tenant_id: json['tenant_id'],
      avatar: json['avatar'],
      commission_rate: json['commission_rate'],
      email: json['email'],
      role_id: json['role_id'],
      closing_time: json['closing_time'],
      opening_time: json['opening_time'],
      email_verified_at: json['email_verified_at'],
      status: json['status'],
      created_at: json['created_at'],
      deleted_at: json['deleted_at'],
      updated_at: json['updated_at'],
    );
  }
}
