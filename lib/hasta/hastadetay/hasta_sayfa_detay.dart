import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/hasta/hastadetay/tedavi_ekle.dart';
import 'package:dental_asistanim/hasta/hastadetay/tedaviler_sayfa.dart';
import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import 'cari_hareketler_sayfa.dart';

class HastaDetaySayfa extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  const HastaDetaySayfa({super.key, required this.id});
  final String id;
  @override
  _HastaDetaySayfaState createState() => _HastaDetaySayfaState();
}

class _HastaDetaySayfaState extends State<HastaDetaySayfa> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    TedavilerSayfasi(),
    TedaviEkle(),
    CariHareketler()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    hastaInfo();
    // TODO: implement initState
    super.initState();
  }

  Future<HastaInfoModel> hastaInfo() async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/appointments/' + widget.id);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'branchId': '${Config.subeid}',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZmE1OWYyOTc0MjVhMGYyYWFmN2ZjNWVmNjBmNjk5OWExYzIxMjdhZDk5OGMwN2M0MGU4ODZlZTI5N2JkYjJjMTE4ZmZiZjgxNGZlNTlhNzciLCJpYXQiOjE2Nzg2OTUxMzYuMDE4MDY1LCJuYmYiOjE2Nzg2OTUxMzYuMDE4MDY4LCJleHAiOjE2OTQ1OTI3MzYuMDEzMjkzLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.GzsExMSxt_K-lHCIVNAoNSEEawwJJMgIp84iG1WnfelmIIrHN0Lu8Tr9XmWiHmhioJzAUnQNn4aSSJBAChpoQYLmZiSb37w7nLfVR6AJugD6_ffQIHKLVqY6a1tu0K8PM5WaxYksC6By86UjrW2_bipdbqU3i9laBQTj6vz8XsZXJvCuL6Ib2WVkS9c8KfnXlDCQ2epH-bgKJ6X2Pue5Ga8UdQVEIDKw0icuzQVWu88372zCavgwjrYOF5ZI5lohS1L4SKT6gxfhcl-MP17GheeemakJksUG9CXFCmfkNRTTArC9pthJvK6iSOlgkIntso85iG8WH8xzMvzO0oo_Qy5sGcFUwue3saxxoP5MXkZLiTVI9MD7GdFxGGkq2oKnhsNGXW3K-MNKqbG3Ez9ypcKr-NMwYejAGg3NDWAF9mr2AO8u6IfvOwzhWETs7FlaWiawxop-PxvjPCtB_efK41BFSIixRqWqIKdGpOEPK-5btMbnZK6Pg2DXkK8txFOdUs0uMM9eJXm9M5PEzGIdJQrG4xH2O7axLaflJ-HjMV6sH_fqclMipuLZtBwldA5VzhjVapE4MKSsbbVpA-XuWzJFPh2vitjtvbfamyqHEetR_BdMNLo-kHzNF9yv2q2ftxf1DHpKv0eLOCPscTU2E0IUcWaLGf6-0QffW1wgjx0'
        },
      );

      if (response.statusCode == 200) {
        String responseString = response.body;

        Map<String, dynamic> responseData = json.decode(responseString);

        print(response.body);
        return HastaInfoModel.fromJson(jsonDecode(responseString));
        // print(responseData["data"]);

        // return (responseData["data"]);
      } else {
        return throw Exception("");
      }
    } catch (e) {
      return throw Exception(e);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hastaInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: null,
              backgroundColor: solidColor,
              toolbarHeight:
                  SizeConfig.safeBlockHorizontal * 60, // Set this height
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Container(
                    color: solidColor,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Container(
                        width: SizeConfig.safeBlockVertical * 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        height: 190,
                        padding: const EdgeInsets.symmetric(
                            vertical: 48, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.data!.patient?.name
                                          .toString() ??
                                      "Hasta Adı Yok",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Tc : ${snapshot.data!.data!.patient?.identityNumber ?? " "}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Referans : ${snapshot.data!.data!.patient?.tenantId}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Telefon : ${snapshot.data!.data!.patient?.phone}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage: CachedNetworkImageProvider(snapshot
                                      .data!.data!.patient?.avatarPath ??
                                  "https://www.w3schools.com/howto/img_avatar.png"),
                              radius: 48.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: solidColor,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Icons.bar_chart_rounded),
                  title: const Text("Tedaviler"),
                  selectedColor: solidColor,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: Icon(Icons.add_chart_outlined),
                  title: Text("Tedavi Ekle"),
                  selectedColor: solidColor,
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: Icon(Icons.money_sharp),
                  title: Text("Cari Hareketler"),
                  selectedColor: solidColor,
                ),

                /// Profile
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class HastaInfoModel {
  bool? success;
  String? message;
  Data? data;

  HastaInfoModel({this.success, this.message, this.data});

  HastaInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? branchId;
  int? appointmentFor;
  int? appointmentWith;
  int? treatmentGroupId;
  String? startAt;
  String? endAt;
  String? note;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Patient? patient;
  Doctor? doctor;

  Data(
      {this.id,
      this.branchId,
      this.appointmentFor,
      this.appointmentWith,
      this.treatmentGroupId,
      this.startAt,
      this.endAt,
      this.note,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.patient,
      this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    appointmentFor = json['appointment_for'];
    appointmentWith = json['appointment_with'];
    treatmentGroupId = json['treatment_group_id'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    note = json['note'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['appointment_for'] = this.appointmentFor;
    data['appointment_with'] = this.appointmentWith;
    data['treatment_group_id'] = this.treatmentGroupId;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['note'] = this.note;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Patient {
  int? id;
  int? tenantId;
  int? doctorId;
  Null? avatar;
  String? documentNo;
  String? identityNumber;
  Null? nationality;
  String? name;
  Null? email;
  String? phone;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? avatarPath;

  Patient(
      {this.id,
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
      this.avatarPath});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    doctorId = json['doctor_id'];
    avatar = json['avatar'];
    documentNo = json['document_no'];
    identityNumber = json['identity_number'];
    nationality = json['nationality'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    avatarPath = json['avatar_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenant_id'] = this.tenantId;
    data['doctor_id'] = this.doctorId;
    data['avatar'] = this.avatar;
    data['document_no'] = this.documentNo;
    data['identity_number'] = this.identityNumber;
    data['nationality'] = this.nationality;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['avatar_path'] = this.avatarPath;
    return data;
  }
}

class Doctor {
  int? id;
  int? roleId;
  int? tenantId;
  String? name;
  String? email;
  String? phone;
  int? commissionRate;
  Null? emailVerifiedAt;
  Null? avatar;
  int? status;
  Null? openingTime;
  Null? closingTime;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Doctor(
      {this.id,
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
      this.deletedAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    tenantId = json['tenant_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    commissionRate = json['commission_rate'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    status = json['status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['commission_rate'] = this.commissionRate;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
