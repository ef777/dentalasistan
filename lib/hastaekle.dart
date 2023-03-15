import 'dart:convert';
import 'dart:developer';
import 'package:dental_asistanim/home_view.dart';
import 'package:dental_asistanim/randevuekle.dart';
import 'package:http/http.dart' as http;

import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/custon_button.dart';
import 'package:dental_asistanim/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config.dart';

class Hastaekle extends StatefulWidget {
  @override
  _HastaekleState createState() => _HastaekleState();
}

class _HastaekleState extends State<Hastaekle> {
  String _randevuNotu = "";
  String _dosyano = "";
  String _tcno = "";
  String _adsoyad = "";
  String _anneadi = "";
  String _babaadi = "";
  String _dogumtarihi = "";
  String _cinsiyet = "";
  List<String> _cinsiyetliste = [
    'Seçiniz',
    'Erkek',
    'Kadın',
  ];

  String _kangrubu = 'Seçiniz';
  List<String> _kangrubuliste = [
    'Seçiniz',
    'A+',
    'B+',
    'AB+',
    '0+',
    'A-',
    'B-',
    'AB-',
    '0-',
  ];
  String _yuzsekli = "Seçiniz";
  List<String> _yuzsekliliste = [
    'Seçiniz',
    'Kare',
    'Dikdörtgen',
    'Oval',
    'Üçgen'
  ];
  String _telefonno = "";

  String _eposta = "";
  String _adres = "";
  String _ulke = "";
  String _il = "";
  String _ilce = "";
  String _indirim = "";
  String _referans = "";
  String _onemlinot = "";
  String _hastaturu = "Seçiniz";
  List<String> _hastaturuliste = [
    'Seçiniz',
    'Aktif',
    'Potansiyel',
    'Pasif',
  ];
  String _hekim = "";
  List<String> _hekimliste = [
    'Seçiniz',
    'Dr. Ali',
  ];
  List<String> _hekimlistedeger = [
    'Seçiniz',
  ];

  String _herhangitedavi = "";
  String _ilackullan = "";
  String _hastalik = "";
  String _ilacalerji = "";
  String _hamilelidusuk = "";
  String _kotualiskanlik = "";
  String _tehlikeliilackullanilan = "";
  String _basveboyunradyoterapi = "";
  List<String> _basveboyunradyoterapiliste = [
    'Seçiniz',
    'Evet',
    'Hayır',
  ];

  String _kanamauzun = "";
  List<String> _kanamauzunliste = [
    'Seçiniz',
    'Evet',
    'Hayır',
  ];
  String _herhangibirtibbisorun = "";
  String _ensondishekimitedavi = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        print(responseData["data"]);
        print(responseData);
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

  hastaekle(
    ad,
    numara,
    uyari,
    doctorid,
  ) async {
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/patients');
      var response = await http.post(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Config.token}'
      }, body: {
        "name": "${ad.toString()}",
        "phone": "${numara.toString()}",
        "warn": "${uyari.toString()}",
        "doctor_id": "${doctorid.toString()}",
      });
      String responseString = response.body;
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        print("başarılı");
        print(responseData);
        return true;
      } else {
        print("başarısız");
        print(responseData);
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  doktorsec(doktor) {
    _hekimliste.clear();
    _hekimlistedeger.clear();
    for (var i = 0; i < doktor.length; i++) {
      _hekimliste.add(doktor[i]["name"]);
      _hekimlistedeger.add(doktor[i]["id"].toString());
    }
  }

  @override
  void initState() {
    super.initState();
    var doktor = doktorliste();

    print("doktor");
    print(doktor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sfColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Hasta Ekle",
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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen ad ve soyad girin';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Ad - Soyad",
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
                            _adsoyad = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Numara Giriniz';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Numara",
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
                            _telefonno = value.toString();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Önemli Not",
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
                            _onemlinot = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Hekim Seçiniz';
                          }
                          return null;
                        },
                        value: _hekim.isEmpty ? null : _hekim,
                        items: _hekimliste.map((String value) {
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
                          labelText: "Hekim",
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
                              var index = _hekimliste.indexOf(value);
                              _hekim = _hekimlistedeger[index];
                            } else {
                              _hekim = "";
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CustomButton(
                          height: 48,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var son = await hastaekle(
                                  _adsoyad.toString(),
                                  _telefonno.toString(),
                                  _onemlinot.toString(),
                                  _hekim.toString());
                              if (son == true) {
                                Get.snackbar('Başarılı', 'Hasta Eklendi');

                                Get.to(RandevuEkle());
                              } else {
                                Get.snackbar('Başarısız', 'Hasta Eklenmedi!');
                              }
                            }
                          },
                          title: "Kaydet",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
