import 'dart:convert';
import 'dart:developer';
import 'package:dental_asistanim/home_view.dart';
import 'package:dental_asistanim/randevu/randevuekle.dart';
import 'package:http/http.dart' as http;
import 'package:dental_asistanim/models/doctormodel.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/etc/custon_button.dart';
import 'package:dental_asistanim/randevu/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';

class Hastaekle extends StatefulWidget {
  @override
  _HastaekleState createState() => _HastaekleState();
}

class _HastaekleState extends State<Hastaekle> {
  String _adsoyad = "";

  String _telefonno = "";

  String _onemlinot = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  List<doktorgetmodel> doktor = [];
  doktorgetmodel? secilendoktor;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final veri1 = await doktorgetmodel.doktorliste();
      print("hastalar");
      print(veri1);
      setState(() {
        doktor = veri1;
      });
    });

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
                      DropdownButtonFormField<doktorgetmodel>(
                        value: secilendoktor,
                        items: doktor?.map((doktorgetmodel value) {
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
                            secilendoktor = value;
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
                                  secilendoktor!.id.toString());
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
