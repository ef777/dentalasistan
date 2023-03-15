import 'dart:convert';

import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dental_asistanim/hastamodel.dart';

import 'config.dart';
import 'custon_button.dart';

class RandevuEkle extends StatefulWidget {
  @override
  _RandevuEkleState createState() => _RandevuEkleState();
}

class _RandevuEkleState extends State<RandevuEkle> {
  HastaModel? _selectedHasta;
  String _selectedRandevuTuru = "Seçiniz";
  String _selectedHekim = "Seçiniz";
  String _selectedRandevuDurumu = "Seçiniz";
  String _randevuNotu = "";

  List<HastaModel> hastaListesi = [];

  List<String> randevuTurleri = [
    'Seçiniz',
    'Acil',
    'Normal',
    'Kontrol',
  ];
  List<String> randevuDurumu = [
    'Seçiniz',
    'Hasta Bekleniyor',
    'Hasta Randevuya Geldi',
    'Hasta Randevuyu İptal Etti',
    'Hasta Randevuyu Gelmedi'
  ];

  List<String> hekimler = [
    'Seçiniz',
    'Dr. Ali',
    'Dr. Ayşe',
    'Dr. Mehmet',
  ];
  randevuturugrup() async {
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
        return responseData["data"];
      } else {
        print("başarısız");
        print(responseData);
      }
    } catch (e) {
      print(e);
    }
  }

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

  doktorliste() async {
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

        print(responseData["data"]);
        return responseData["data"];
      } else {
        print("başarısız");
        print(responseData);
        return "0";
      }
    } catch (e) {
      print("hata");
      print(e);
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

  randevuekle() async {
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/appointments');
      var response = await http.post(url, headers: {
        'Accept': 'application/json',
        'branchId': '${Config.subeid}',
        'Authorization': 'Bearer ${Config.token}'
      }, body: {
        "patient_id": "1",
        "doctor_id": "1",
        "treatment_group_id": "1",
        "start_at": "2021-09-01 10:00",
        "end_at": "2021-10-01 10:00",
      });
      String responseString = response.body;
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        print("başarılı");
        print(responseData);
      } else {
        print(responseData);
        print("başarısız");
      }
    } catch (e) {
      print("");
    }
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

    var doktor = doktorliste();
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
                      DropdownButtonFormField<String>(
                        value: _selectedRandevuTuru.isEmpty
                            ? null
                            : _selectedRandevuTuru,
                        items: randevuTurleri.map((String value) {
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
                            if (value != null) {
                              _selectedRandevuTuru = value;
                            } else {
                              _selectedRandevuTuru = "";
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedHekim.isEmpty ? null : _selectedHekim,
                        items: hekimler.map((String value) {
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
                          labelText: "Hekim Seçiniz",
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
                              _selectedHekim = value;
                            } else {
                              _selectedHekim = "";
                            }
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
                            await randevuekle();
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
