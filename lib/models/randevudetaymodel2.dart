// To parse this JSON data, do
//
//     final randevudetay2 = randevudetay2FromJson(jsonString);
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../config.dart';

class Randevudetay2 {
  Randevudetay2({
    required this.success,
    required this.message,
    required this.datares,
  });

  final bool success;
  final String message;
  final DataRandevu datares;
  static Future<DataRandevu> randevudetaygetir(id) async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/appointments/${id.toString()}');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Config.token}'
        },
      );

      if (response.statusCode == 200) {
        String responseString = response.body;

        Map<String, dynamic> responseDataRandevu = json.decode(responseString);

        Randevudetay2 resp = (Randevudetay2.fromJson(responseDataRandevu));
        var sonuc = resp.datares;
        //print(response.body);
        print("başarılı");
        return sonuc;
      } else {
        print("başarısız");
        print(response);
        return DataRandevu.fromJson({});
      }
    } catch (e) {
      print(e);
      return DataRandevu.fromJson({});
    }
  }

  factory Randevudetay2.fromRawJson(String str) =>
      Randevudetay2.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Randevudetay2.fromJson(Map<String, dynamic> json) => Randevudetay2(
        success: json["success"],
        message: json["message"],
        datares: DataRandevu.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": datares.toJson(),
      };
}

class DataRandevu {
  DataRandevu({
    required this.id,
    required this.branchId,
    required this.appointmentFor,
    required this.appointmentWith,
    required this.treatmentGroupId,
    required this.startAt,
    required this.endAt,
    this.note,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.patient,
    required this.doctor,
  });

  final int id;
  final int branchId;
  final int appointmentFor;
  final int appointmentWith;
  final int treatmentGroupId;
  final DateTime startAt;
  final DateTime endAt;
  final dynamic note;
  final int status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic patient;
  final Doctor doctor;

  factory DataRandevu.fromRawJson(String str) =>
      DataRandevu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRandevu.fromJson(Map<String, dynamic> json) => DataRandevu(
        id: json["id"],
        branchId: json["branch_id"],
        appointmentFor: json["appointment_for"],
        appointmentWith: json["appointment_with"],
        treatmentGroupId: json["treatment_group_id"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        note: json["note"],
        status: json["status"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        patient: json["patient"],
        doctor: Doctor.fromJson(json["doctor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "appointment_for": appointmentFor,
        "appointment_with": appointmentWith,
        "treatment_group_id": treatmentGroupId,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "note": note,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "patient": patient,
        "doctor": doctor.toJson(),
      };
}

class Doctor {
  Doctor({
    required this.id,
    required this.roleId,
    this.tenantId,
    required this.name,
    required this.email,
    required this.phone,
    this.commissionRate,
    this.emailVerifiedAt,
    this.avatar,
    required this.status,
    this.openingTime,
    this.closingTime,
    this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final int roleId;
  final dynamic tenantId;
  final String name;
  final String email;
  final String phone;
  final dynamic commissionRate;
  final dynamic emailVerifiedAt;
  final dynamic avatar;
  final int status;
  final dynamic openingTime;
  final dynamic closingTime;
  final dynamic createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        roleId: json["role_id"],
        tenantId: json["tenant_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        commissionRate: json["commission_rate"],
        emailVerifiedAt: json["email_verified_at"],
        avatar: json["avatar"],
        status: json["status"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "tenant_id": tenantId,
        "name": name,
        "email": email,
        "phone": phone,
        "commission_rate": commissionRate,
        "email_verified_at": emailVerifiedAt,
        "avatar": avatar,
        "status": status,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
