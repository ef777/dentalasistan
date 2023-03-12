import 'package:dental_asistanim/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hasta Ekle'),
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
                  SizedBox(height: 20),
                  Text(
                    'Dosya No :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _dosyano = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'T.C. No. :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _tcno = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Adı Soyadı :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _adsoyad = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Anne Adı :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _anneadi = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Baba Adı :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _babaadi = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Doğum Tarihi :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    autofillHints: [AutofillHints.birthday],
                    maxLines: 1,
                    decoration: InputDecoration(
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
                  SizedBox(height: 20),
                  Text(
                    'Cinsiyet :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _cinsiyet.isEmpty ? null : _cinsiyet,
                    items: _cinsiyetliste.map((String value) {
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
                          _cinsiyet = value;
                        } else {
                          _cinsiyet = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kan Grubu :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _kangrubu.isEmpty ? null : _kangrubu,
                    items: _kangrubuliste.map((String value) {
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
                          _kangrubu = value;
                        } else {
                          _kangrubu = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Yüz Şekli :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _yuzsekli.isEmpty ? null : _yuzsekli,
                    items: _yuzsekliliste.map((String value) {
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
                          _yuzsekli = value;
                        } else {
                          _yuzsekli = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Telefon Numarası :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _telefonno = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'E-posta :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _eposta = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Adres :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _adres = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ülke :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _ulke = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'İl :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _il = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'İlce :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _ilce = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'İndirim :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _indirim = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Referans :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _referans = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Önemli Not :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _onemlinot = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Hasta Türü :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _hastaturu.isEmpty ? null : _hastaturu,
                    items: _hastaturuliste.map((String value) {
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
                          _hastaturu = value;
                        } else {
                          _hastaturu = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Hekim :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _hekim.isEmpty ? null : _hekim,
                    items: _hekimliste.map((String value) {
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
                          _hekim = value;
                        } else {
                          _hekim = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Herhangi bir tedavi görüyor musunuz? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _herhangitedavi = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'İlaç kullanıyor musunuz? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _ilackullan = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Herhangi bir hastalığınız var mı,geçirdiniz mi? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _herhangibirtibbisorun = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'İlaç alerjiniz var mı? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _ilacalerji = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kadınlarda hamilelik,düşük,adet ve menapoz bilgileri? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _hamilelidusuk = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kötü alışkanlıklarınız var mı? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _kotualiskanlik = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kullanılan tehlikeli ilaçlar? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _tehlikeliilackullanilan = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Baş ve boyun bölgesinde radyoterapi gördünüz mü? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _basveboyunradyoterapi.isEmpty
                        ? null
                        : _basveboyunradyoterapi,
                    items: _basveboyunradyoterapiliste.map((String value) {
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
                          _basveboyunradyoterapi = value;
                        } else {
                          _basveboyunradyoterapi = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kanama uzun sürer mi? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _kanamauzun.isEmpty ? null : _kanamauzun,
                    items: _kanamauzunliste.map((String value) {
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
                          _kanamauzun = value;
                        } else {
                          _kanamauzun = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bunların dışında herhangi bir tıbbı sorununuz var mı? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _herhangibirtibbisorun = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'En son dişhekimi muayenesi ve tedavisi? :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 1,
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
                        _ensondishekimitedavi = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(AppointmentPage());
                      if (_formKey.currentState!.validate()) {}
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
