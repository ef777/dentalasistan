import 'dart:convert';
import 'dart:developer';
import 'package:dental_asistanim/home_view.dart';
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
  hastaekle(
    String ad,
    String numara,
    String uyari,
    String doctorid,
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
        "doctor_id": 53
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
                      /* Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hasta Ekle",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ), */
                      /*   SizedBox(height: 20),
                      Text(
                        'Randevua Notu Giriniz',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
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
                      ), */

                      //   const SizedBox(height: 10),
                      /*    TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "Dosya No",
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dosyano = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          labelText: "T.C. Kimlik Numarası",
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
                            _tcno = value;
                          });
                        },
                      ), */
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
/*                       SizedBox(height: 10),
 */ /*  TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Anne Adı",
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
                            _anneadi = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10), */
                      /*   TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Baba Adı",
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
                            _babaadi = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autofillHints: const [AutofillHints.birthday],
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Doğum Tarihi",
                          hintText: 'GG/AA/YYYY',
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
                            _dogumtarihi = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _cinsiyet.isEmpty ? null : _cinsiyet,
                        items: _cinsiyetliste.map((String value) {
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
                          labelText: "Cinsiyet",
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
                              _cinsiyet = value;
                            } else {
                              _cinsiyet = "";
                            }
                          });
                        },
                      ), */
                      /*  const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _kangrubu.isEmpty ? null : _kangrubu,
                        items: _kangrubuliste.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value.isEmpty ? null : value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: "Kan Grubu",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                              _kangrubu = value;
                            } else {
                              _kangrubu = "";
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10), */
                      /*    DropdownButtonFormField<String>(
                        value: _yuzsekli.isEmpty ? null : _yuzsekli,
                        items: _yuzsekliliste.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value.isEmpty ? null : value,
                            child: new Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Yüz Şekli",
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
                              _yuzsekli = value;
                            } else {
                              _yuzsekli = "";
                            }
                          });
                        },
                      ), */
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
                      /*  const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Email",
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
                            _eposta = value;
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
                          labelText: "Adres",
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
                            _adres = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10), */
                      /*  TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Ülke",
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
                            _ulke = value;
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
                          labelText: "İl",
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
                            _il = value;
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
                          labelText: "İlce",
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
                            _ilce = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "İndirim",
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
                            _indirim = value;
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
                          labelText: "Referans",
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
                            _referans = value;
                          });
                        },
                      ), */
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
                      /*   const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _hastaturu.isEmpty ? null : _hastaturu,
                        items: _hastaturuliste.map((String value) {
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
                          labelText: "Hasta Türü",
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
                              _hastaturu = value;
                            } else {
                              _hastaturu = "";
                            }
                          });
                        },
                      ),*/
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
                              _hekim = value;
                            } else {
                              _hekim = "";
                            }
                          });
                        },
                      ),
                      /*  const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Herhangi bir tedavi görüyor musunuz?',
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
                            _herhangitedavi = value;
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
                          labelText: "İlaç kullanıyor musunuz",
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
                            _ilackullan = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10), */
                      /*  TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText:
                              "Herhangi bir hastalığınız var mı, geçirdiniz mi ?",
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
                            _herhangibirtibbisorun = value;
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
                          labelText: "İla. alerjiniz var mı ? ",
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
                            _ilacalerji = value;
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
                          labelText:
                              'Kadınlarda hamilelik,düşük,adet ve menapoz bilgileri ?',
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
                            _hamilelidusuk = value;
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
                          labelText: "Kötü alışkanlıpınız var mı",
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
                            _kotualiskanlik = value;
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
                          labelText: "Kullanılan tehkileli ilaçlar",
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
                            _tehlikeliilackullanilan = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _basveboyunradyoterapi.isEmpty
                            ? null
                            : _basveboyunradyoterapi,
                        items: _basveboyunradyoterapiliste.map((String value) {
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
                          labelText:
                              "Baş boyun bölgesinde radyoterapi gördünüz mü ?",
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
                              _basveboyunradyoterapi = value;
                            } else {
                              _basveboyunradyoterapi = "";
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _kanamauzun.isEmpty ? null : _kanamauzun,
                        items: _kanamauzunliste.map((String value) {
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
                          labelText: "Kanama uzun sürer mi ?",
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
                              _kanamauzun = value;
                            } else {
                              _kanamauzun = "";
                            }
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
                          labelText:
                              "Bunların dışında herhangi bir tıbbı sorununuz var mı ?",
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
                            _herhangibirtibbisorun = value;
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
                          labelText: 'En son dişhekimi muayenesi ve tedavisi?',
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
                            _ensondishekimitedavi = value;
                          });
                        },
                      ), */
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

                                Get.to(AppointmentPage());
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
