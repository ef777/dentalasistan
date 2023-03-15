// To parse this JSON data, do
//
//     final randevusayfa = randevusayfaFromJson(jsonString);
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'config.dart';

class Randevusayfa {
  Randevusayfa({
    required this.success,
    required this.message,
    required this.data,
  });
  static Future<List<Datum>> randevugetir() async {
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/appointments');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'branchId': '${Config.subeid}',
          'Authorization': 'Bearer ${Config.token}'
        },
      );

      if (response.statusCode == 200) {
        String responseString = response.body;

        Map<String, dynamic> responseData = json.decode(responseString);

        Randevusayfa resp = (Randevusayfa.fromJson(responseData));
        var sonuc = resp.data.data;

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

  final bool success;
  final String message;
  final Data data;

  factory Randevusayfa.fromRawJson(String str) =>
      Randevusayfa.fromJson(json.decode(str));

  factory Randevusayfa.fromJson(Map<String, dynamic> json) => Randevusayfa(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<Datum> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic? prevPageUrl;
  final int? to;
  final int? total;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class Datum {
  Datum({
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
  final Patient? patient;
  final Doctor doctor;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        patient:
            json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        doctor: Doctor.fromJson(json["doctor"]),
      );
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
  final int? tenantId;
  final String name;
  final String email;
  final String phone;
  final int? commissionRate;
  final dynamic emailVerifiedAt;
  final dynamic avatar;
  final int status;
  final dynamic openingTime;
  final dynamic closingTime;
  final DateTime? createdAt;
  final DateTime updatedAt;
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
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
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
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String label;
  final bool active;

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
