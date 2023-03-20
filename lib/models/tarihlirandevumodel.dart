// To parse this JSON data, do
//
//     final tarihliRandevu = tarihliRandevuFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';

class TarihliRandevu {
  TarihliRandevu({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<Datum2> data;
  static Future<List<Datum2>> tarihlirandevugetir(tarih) async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/appointments-by-date/${tarih}');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'branchId': '${Config.subeid}',
          'Authorization': 'Bearer ${Config.token}'
        },
      );

      if (response.statusCode == 200) {
        print("tarihli fonk başarılı");
        String responseString = response.body;

        Map<String, dynamic> responseData = json.decode(responseString);
        print("tarihli fonk başarılı2");

        TarihliRandevu resp = (TarihliRandevu.fromJson(responseData));
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

  factory TarihliRandevu.fromRawJson(String str) =>
      TarihliRandevu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TarihliRandevu.fromJson(Map<String, dynamic> json) => TarihliRandevu(
        success: json["success"],
        message: json["message"],
        data: List<Datum2>.from(json["data"].map((x) => Datum2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum2 {
  Datum2({
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
    required this.patient,
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
  final Patient patient;
  final Doctor doctor;

  factory Datum2.fromRawJson(String str) => Datum2.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum2.fromJson(Map<String, dynamic> json) => Datum2(
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
        patient: Patient.fromJson(json["patient"]),
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
        "patient": patient.toJson(),
        "doctor": doctor.toJson(),
      };
}

class Doctor {
  Doctor({
    required this.id,
    required this.roleId,
    required this.tenantId,
    required this.name,
    required this.email,
    required this.phone,
    required this.commissionRate,
    this.emailVerifiedAt,
    this.avatar,
    required this.status,
    this.openingTime,
    this.closingTime,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final int roleId;
  final int tenantId;
  final String name;
  final String email;
  final String phone;
  final int commissionRate;
  final dynamic emailVerifiedAt;
  final dynamic avatar;
  final int status;
  final dynamic openingTime;
  final dynamic closingTime;
  final DateTime createdAt;
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
        createdAt: DateTime.parse(json["created_at"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Patient {
  Patient({
    required this.id,
    required this.tenantId,
    required this.doctorId,
    this.avatar,
    this.documentNo,
    this.identityNumber,
    this.nationality,
    required this.name,
    this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.avatarPath,
  });

  final int id;
  final int tenantId;
  final int doctorId;
  final dynamic avatar;
  final dynamic documentNo;
  final dynamic identityNumber;
  final dynamic nationality;
  final String name;
  final dynamic email;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final dynamic avatarPath;

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        tenantId: json["tenant_id"],
        doctorId: json["doctor_id"],
        avatar: json["avatar"],
        documentNo: json["document_no"],
        identityNumber: json["identity_number"],
        nationality: json["nationality"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        avatarPath: json["avatar_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenant_id": tenantId,
        "doctor_id": doctorId,
        "avatar": avatar,
        "document_no": documentNo,
        "identity_number": identityNumber,
        "nationality": nationality,
        "name": name,
        "email": email,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "avatar_path": avatarPath,
      };
}
