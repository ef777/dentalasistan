import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/hastaDetay/tedavi_ekle.dart';
import 'package:dental_asistanim/hastaDetay/tedaviler_sayfa.dart';
import 'package:dental_asistanim/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'cari_hareketler_sayfa.dart';

class HastaDetaySayfa extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: solidColor,
        toolbarHeight: SizeConfig.safeBlockHorizontal * 60, // Set this height
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 48, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Önder Akkaya",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Tc :",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Referans",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Telefon : ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage:
                            const AssetImage("assets/avatarImage.png"),
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
  }
}
