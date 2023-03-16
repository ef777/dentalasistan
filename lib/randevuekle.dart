import 'dart:convert';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dental_asistanim/hastamodel.dart';

import 'config.dart';
import 'custon_button.dart';

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

class randevugrupmodel {
  int? id;
  String? name;
  String? class_name;
  static Future<List<randevugrupmodel>> randevuturugrup() async {
    try {
      var url =
          Uri.parse('https://demo.dentalasistanim.com/api/treatment-groups');
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
        print("randevutur");
        print(responseData["data"]);
        List<randevugrupmodel> grupmodels = [];
        for (var randevugrupmodeljson in responseData['data']) {
          grupmodels.add(randevugrupmodel.fromJson(randevugrupmodeljson));
        }
        print("başarısız");
        print(responseData);
        return grupmodels;
      } else {
        return [];
      }
    } catch (e) {
      return [];
      print(e);
    }
  }

  randevugrupmodel({
    required this.id,
    required this.name,
    required this.class_name,
  });
  factory randevugrupmodel.fromJson(Map<String, dynamic> json) {
    return randevugrupmodel(
      id: json['id'],
      name: json['name'],
      class_name: json['class_name'],
    );
  }
}

class RandevuEkle extends StatefulWidget {
  @override
  _RandevuEkleState createState() => _RandevuEkleState();
}

class _RandevuEkleState extends State<RandevuEkle> {
  HastaModel? _selectedHasta;
  randevugrupmodel? _selectedRandevuTuru;

  doktorgetmodel? _selectedHekim;
  String _selectedRandevuDurumu = "Seçiniz";
  String _randevuNotu = "";

  List<HastaModel> hastaListesi = [];
  DateTime? startDate;
  DateTime? endDate;
  List<randevugrupmodel> randevuTurleri = [];

  List<String> randevuDurumu = [
    'Seçiniz',
    'Hasta Bekleniyor',
    'Hasta Randevuya Geldi',
    'Hasta Randevuyu İptal Etti',
    'Hasta Randevuyu Gelmedi'
  ];

  List<doktorgetmodel> hekimler = [];

  randevudurumlar() async {
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
        print(responseData["data"]);
        return responseData["data"];
      } else {
        print("başarısız");
        print(responseData);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<doktorgetmodel>> doktor() async {
    try {
      List<doktorgetmodel> doktor = await doktorgetmodel.doktorliste();
      return doktor;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<randevugrupmodel>> randevugrup() async {
    try {
      List<randevugrupmodel> hasta = await randevugrupmodel.randevuturugrup();
      return hasta;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<HastaModel>> hasta() async {
    try {
      List<HastaModel> hasta = await HastaModel.hastagetir();
      return hasta;
    } catch (e) {
      print(e);
      return [];
    }
  }

  randevuekle(hastaid, randevutur, doktor, not, durum) async {
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/appointments');
      var response = await http.post(url, headers: {
        'Accept': 'application/json',
        'branchId': '${Config.subeid}',
        'Authorization': 'Bearer ${Config.token}'
      }, body: {
        "patient_id": "${hastaid.toString()}",
        "doctor_id": "${doktor.toString()}",
        "treatment_group_id": "${randevutur.toString()}",
        "start_at": "2023-04-17 10:00",
        "end_at": "2024-10-01 10:00",
      });
      String responseString = response.body;
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        print("başarılı");
        print(responseData);
        return true;
      } else {
        print(responseData);
        print("başarısız");
        return false;
      }
    } catch (e) {
      print("hataa");
      return false;
    }
  }

  tarihsec() {
    showCustomDateRangePicker(
      primaryColor: solidColor,
      backgroundColor: solidColor,
      context,
      dismissible: true,
      minimumDate: DateTime.now().subtract(const Duration(days: 30)),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: endDate,
      startDate: startDate,
      onApplyClick: (start, end) {
        setState(() {
          endDate = end;
          startDate = start;
        });
      },
      onCancelClick: () {
        setState(() {
          endDate = null;
          startDate = null;
        });
      },
    );
    return true;
  }

  String _searchText = "";

  List<HastaModel> _searchResult = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      hastaListesi = [];
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final hastaList = await hasta();
      setState(() {
        hastaListesi = hastaList;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final randevu = await randevugrup();
      setState(() {
        randevuTurleri = randevu;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final doktorlar = await doktor();
      setState(() {
        hekimler = doktorlar;
      });
    });

    var durum = randevudurumlar();

    Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sfColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Randevu Ekle",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: Image.asset(
                "assets/image2.png",
                height: 200,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 8.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dfBorderRadius),
                    topRight: Radius.circular(dfBorderRadius),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Hasta ismi...',
                            ),
                            onChanged: (text) {
                              setState(() {
                                _searchText = text;
                                _searchResult = hastaListesi
                                    .where((hasta) => hasta.name
                                        .toLowerCase()
                                        .contains(_searchText.toLowerCase()))
                                    .toList();
                              });
                            },
                          ),
                          SizedBox(
                              height:
                                  10), // arama kutusu ile seçici arasına boşluk ekler
                          DropdownButtonFormField<HastaModel>(
                            value: _selectedHasta,
                            items: _searchText.isEmpty
                                ? hastaListesi.map((HastaModel value) {
                                    return DropdownMenuItem<HastaModel>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList()
                                : _searchResult.map((HastaModel value) {
                                    return DropdownMenuItem<HastaModel>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: solidColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Hasta Seçiniz",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedHasta = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<randevugrupmodel>(
                        value: _selectedRandevuTuru,
                        items: randevuTurleri.map((randevugrupmodel value) {
                          return DropdownMenuItem<randevugrupmodel>(
                            value: value,
                            child: Text(value.name!),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Randevu Türü Seçiniz",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedRandevuTuru = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<doktorgetmodel>(
                        value: _selectedHekim,
                        items: hekimler.map((doktorgetmodel value) {
                          return DropdownMenuItem<doktorgetmodel>(
                            value: value,
                            child: Text(value.name!),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Doktor Seçiniz",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedHekim = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedRandevuDurumu.isEmpty
                            ? null
                            : _selectedRandevuDurumu,
                        items: randevuDurumu.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value.isEmpty ? null : value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Randevu Durumu Seçiniz",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _selectedRandevuDurumu = value;
                            } else {
                              _selectedRandevuDurumu = "";
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Randevu Notu Giriniz",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _randevuNotu = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CustomButton(
                          height: 48,
                          onPressed: () async {
                            if (endDate.isNull && startDate.isNull) {
                              tarihsec();
                            }
                            if (!endDate.isNull && !startDate.isNull) {
                              var son = await randevuekle(
                                _selectedHasta!.id,
                                _selectedRandevuTuru!.id,
                                _selectedHekim!.id,
                                "not",
                                _selectedRandevuDurumu,
                              );
                              if (son == true) {
                                Get.snackbar('Başarılı', 'Hasta Eklendi');
                              } else {
                                Get.snackbar('Başarısız', 'Hasta Eklenmedi!');
                              }
                            } else {
                              Get.snackbar('Tarih!', 'Tarih Eklenmedi!');

                              tarihsec();
                            }
                          },
                          title: "Kaydet",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
