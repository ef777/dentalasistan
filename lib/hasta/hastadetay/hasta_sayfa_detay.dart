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
// To parse this JSON data, do
//
//     final hastadetay = hastadetayFromJson(jsonString);

import 'dart:convert';

class Hastadetay {
  Hastadetay({
    required this.id,
    required this.avatar,
    required this.name,
    required this.phone,
    this.identityNumber,
    this.referenceName,
    required this.totalIncomePriceTry,
    required this.totalExaminationPriceTry,
    required this.warn,
    this.anyDisease,
    this.drugsUsed,
  });

  final int id;
  final dynamic avatar;
  final String name;
  final String phone;
  final dynamic identityNumber;
  final dynamic referenceName;
  final int totalIncomePriceTry;
  final int totalExaminationPriceTry;
  final dynamic warn;
  final dynamic anyDisease;
  final dynamic drugsUsed;

  factory Hastadetay.fromRawJson(String str) =>
      Hastadetay.fromJson(json.decode(str));

  factory Hastadetay.fromJson(Map<String, dynamic> json) => Hastadetay(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        phone: json["phone"],
        identityNumber: json["identity_number"],
        referenceName: json["reference_name"],
        totalIncomePriceTry: json["total_income_price_try"],
        totalExaminationPriceTry: json["total_examination_price_try"],
        warn: json["warn"],
        anyDisease: json["any_disease"],
        drugsUsed: json["drugs_used"],
      );
}

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

  Future<Hastadetay> hastaInfo() async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/patients/' + widget.id);
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
        print("bu hasta");
        print("hastaid" + widget.id);
        print(responseData);

        return Hastadetay.fromJson(responseData["data"]);
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

// https://demo.dentalasistanim.com/api/patients/2866/examinations?planningId=4
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hastaInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          var hasta = snapshot.data as Hastadetay;
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
                                  hasta.name.toString() ?? "Ad Yok",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Tc : ${hasta.identityNumber}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Referans : ${hasta.referenceName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Telefon : ${hasta.phone}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage: CachedNetworkImageProvider(hasta
                                      .avatar ??
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
