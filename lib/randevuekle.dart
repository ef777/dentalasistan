import 'package:dental_asistanim/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RandevuEkle extends StatefulWidget {
  @override
  _RandevuEkleState createState() => _RandevuEkleState();
}

class _RandevuEkleState extends State<RandevuEkle> {
  String _selectedHasta = 'Seçiniz';
  String _selectedRandevuTuru = "Seçiniz";
  String _selectedHekim = "Seçiniz";
  String _selectedRandevuDurumu = "Seçiniz";
  String _randevuNotu = "";

  List<String> hastaListesi = [
    'Seçiniz',
    'Hasta 1',
    'Hasta 2',
    'Hasta 3',
  ];

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Randevu Ekle'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Hasta Seçiniz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedHasta.isEmpty ? null : _selectedHasta,
                    items: hastaListesi.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.isEmpty ? null : value,
                        child: new Text(value),
                      );
                    }).toList(),
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
                        if (value != null) {
                          _selectedHasta = value;
                        } else {
                          _selectedHasta = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Randevu Türü Seçiniz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedRandevuTuru.isEmpty
                        ? null
                        : _selectedRandevuTuru,
                    items: randevuTurleri.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.isEmpty ? null : value,
                        child: new Text(value),
                      );
                    }).toList(),
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
                        if (value != null) {
                          _selectedRandevuTuru = value;
                        } else {
                          _selectedRandevuTuru = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Hekim Seçiniz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedHekim.isEmpty ? null : _selectedHekim,
                    items: hekimler.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.isEmpty ? null : value,
                        child: new Text(value),
                      );
                    }).toList(),
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
                        if (value != null) {
                          _selectedHekim = value;
                        } else {
                          _selectedHekim = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Randevu Durumu Seçiniz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedRandevuDurumu.isEmpty
                        ? null
                        : _selectedRandevuDurumu,
                    items: randevuDurumu.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.isEmpty ? null : value,
                        child: new Text(value),
                      );
                    }).toList(),
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
                        if (value != null) {
                          _selectedRandevuDurumu = value;
                        } else {
                          _selectedRandevuDurumu = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Randevu Notu Giriniz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
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
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(AppointmentPage());
                      if (_formKey.currentState!.validate()) {
//TODO: Kaydetme işlemi yapılacak.
                      }
                    },
                    child: Text('Kaydet'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
