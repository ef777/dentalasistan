// To parse this JSON data, do
//
//     final Hastatedaviler = HastatedavilerFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';

class Hastatedaviler {
  Hastatedaviler({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<Hastated>? data;

  factory Hastatedaviler.fromRawJson(String str) =>
      Hastatedaviler.fromJson(json.decode(str));

  static Future<List<Hastated>> hastatedavi(id) async {
    print("hastatedavi id" + id.toString());
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/patients/${id}/examinations');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Config.token}'
        },
      );

      if (response.statusCode == 200) {
        String responseString = response.body;

        Map<String, dynamic> responseHastated = json.decode(responseString);

        Hastatedaviler resp = (Hastatedaviler.fromJson(responseHastated));
        var sonuc = resp.data!;
        print("sonuc" + response.toString());
        //print(response.body);
        print("başarılı");

        return sonuc;
      } else {
        print("başarısız");
        print(response);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  factory Hastatedaviler.fromJson(Map<String, dynamic> json) => Hastatedaviler(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Hastated>.from(
                json["data"]!.map((x) => Hastated.fromJson(x))),
      );
}

class Hastated {
  Hastated({
    this.id,
    this.planningId,
    this.date,
    this.toothNumber,
    this.treatmentId,
    this.treatmentName,
    this.doctorId,
    this.tenantId,
    this.doctorName,
    this.treatmentPrice,
    this.appliedPrice,
    this.commissionRate,
    this.note,
    this.canals,
    this.folder,
    this.patientId,
    this.currencyCode,
    this.hideTooth,
    this.createdAt,
    this.updatedAt,
    this.patient,
    this.doctor,
  });

  final int? id;
  final int? planningId;
  final DateTime? date;
  final int? toothNumber;
  final int? treatmentId;
  final String? treatmentName;
  final int? doctorId;
  final int? tenantId;
  final String? doctorName;
  final int? treatmentPrice;
  final int? appliedPrice;
  final int? commissionRate;
  final dynamic note;
  final String? canals;
  final String? folder;
  final int? patientId;
  final String? currencyCode;
  final int? hideTooth;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Patient? patient;
  final Doctor? doctor;

  factory Hastated.fromRawJson(String str) =>
      Hastated.fromJson(json.decode(str));

  factory Hastated.fromJson(Map<String, dynamic> json) => Hastated(
        id: json["id"],
        planningId: json["planning_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        toothNumber: json["tooth_number"],
        treatmentId: json["treatment_id"],
        treatmentName: json["treatment_name"],
        doctorId: json["doctor_id"],
        tenantId: json["tenant_id"],
        doctorName: json["doctor_name"],
        treatmentPrice: json["treatment_price"],
        appliedPrice: json["applied_price"],
        commissionRate: json["commission_rate"],
        note: json["note"],
        canals: json["canals"],
        folder: json["folder"],
        patientId: json["patient_id"],
        currencyCode: json["currency_code"],
        hideTooth: json["hide_tooth"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        patient:
            json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      );
}

class Doctor {
  Doctor({
    this.id,
    this.roleId,
    this.tenantId,
    this.name,
    this.email,
    this.phone,
    this.commissionRate,
    this.emailVerifiedAt,
    this.avatar,
    this.status,
    this.openingTime,
    this.closingTime,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final int? id;
  final int? roleId;
  final int? tenantId;
  final String? name;
  final String? email;
  final String? phone;
  final int? commissionRate;
  final dynamic emailVerifiedAt;
  final dynamic avatar;
  final int? status;
  final dynamic openingTime;
  final dynamic closingTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class Patient {
  Patient({
    this.id,
    this.tenantId,
    this.doctorId,
    this.avatar,
    this.documentNo,
    this.identityNumber,
    this.nationality,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.avatarPath,
  });

  final int? id;
  final int? tenantId;
  final int? doctorId;
  final dynamic avatar;
  final dynamic documentNo;
  final dynamic identityNumber;
  final dynamic nationality;
  final String? name;
  final dynamic email;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic avatarPath;

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        avatarPath: json["avatar_path"],
      );
}
