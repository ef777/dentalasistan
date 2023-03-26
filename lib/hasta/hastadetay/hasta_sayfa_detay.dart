import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/hasta/hastadetay/tedavi_ekle.dart';
import 'package:dental_asistanim/hasta/hastadetay/tedaviler_sayfa.dart';
import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
/*     hastaInfo();
 */ // TODO: implement initState
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: sfColor,
        title: const Text(
          "Hasta Detayı",
        ),
      ),
      // appBar: AppBar(
      //   leading: null,
      //   backgroundColor: solidColor,
      //   toolbarHeight: SizeConfig.safeBlockHorizontal * 40, // Set this height
      // flexibleSpace: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 5),
      //     child: Container(
      //       color: solidColor,
      //       child: Padding(
      //         padding: const EdgeInsets.all(5.0),
      //         child: Container(
      //           width: SizeConfig.safeBlockVertical * 40,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(25),
      //             color: Colors.white,
      //           ),
      //           height: 190,
      //           padding: const EdgeInsets.symmetric(
      //               vertical: 20, horizontal: 15),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     hasta.name.toString() ?? "Ad Yok",
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleMedium
      //                         ?.copyWith(fontWeight: FontWeight.w600),
      //                   ),
      //                   Text(
      //                     "Tc : ${hasta.identityNumber}",
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleMedium
      //                         ?.copyWith(fontWeight: FontWeight.w600),
      //                   ),
      //                   Text(
      //                     "Referans : ${hasta.referenceName}",
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleMedium
      //                         ?.copyWith(fontWeight: FontWeight.w600),
      //                   ),
      //                   Text(
      //                     "Nu : ${hasta.phone}",
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleMedium
      //                         ?.copyWith(fontWeight: FontWeight.w600),
      //                   )
      //                 ],
      //               ),
      //               CircleAvatar(
      //                 backgroundImage: NetworkImage(
      //                     "https://www.w3schools.com/howto/img_avatar.png"),

      //                 // CachedNetworkImageProvider((hasta
      //                 //         .avatar.isEmpty)
      //                 //     ? ("https://www.w3schools.com/howto/img_avatar.png")
      //                 //     : hasta.avatar),
      //                 radius: 48.0,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      //),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       leading: const SizedBox.shrink(),
      //       elevation: 0,
      //       backgroundColor: sfColor,
      //       expandedHeight: SizeConfig.screenHeight * 0.22,
      //       floating: true,
      //       pinned: false,
      //       snap: true,
      //       centerTitle: false,
      //       flexibleSpace: FlexibleSpaceBar(
      //         titlePadding: EdgeInsets.all(0),
      //         background: Column(
      //           children: [
      //             Image.asset(
      //               "assets/doctor1.png",
      //               height: 170,
      //             ),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      // SliverToBoxAdapter(
      //     child: Container(
      //   decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.white.withOpacity(0.3),
      //         offset: const Offset(0, 3),
      //         blurRadius: 8.0,
      //         spreadRadius: 4.0,
      //       ),
      //     ],
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(dfBorderRadius),
      //       topRight: Radius.circular(dfBorderRadius),
      //     ),
      //   ),
      //   child: Column(
      //     children: [
      //       const SizedBox(
      //         height: 16,
      //       ),
      //       Padding(
      //         padding:
      //             const EdgeInsets.only(left: 22, right: 22, bottom: 12),
      //         child: TextField(
      //           onChanged: (value) {
      //             search(_searchController.text);
      //           },
      //           controller: _searchController,
      //           keyboardType: TextInputType.emailAddress,
      //           decoration: InputDecoration(
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(16.0),
      //                 borderSide: BorderSide.none,
      //               ),
      //               filled: true,
      //               fillColor: Color.fromARGB(255, 229, 237, 235),
      //               hintText: "Arama Yap",
      //               prefixIcon: const Icon(
      //                 Icons.search,
      //                 color: Colors.grey,
      //                 size: 22,
      //               )),
      //         ),
      //       ),

      //       // SizedBox(
      //       //   height: 500,
      //       //   child: ListView.builder(
      //       //     shrinkWrap: true,
      //       //     itemCount: filteredVeri.length,
      //       //     itemBuilder: (context, index) {
      //       //       var item = filteredVeri[index];
      //       //       return Center(child: HastaCard(item: item));
      //       //     },
      //       //   ),
      //       // )
      //     ],
      //   ),
      // )),

      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //         childCount: 1,
      //         (BuildContext context, int index) {
      //           return Center(
      //             child: _widgetOptions.elementAt(_selectedIndex),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),

      body: FutureBuilder(
        future: hastaInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            var hasta = snapshot.data as Hastadetay;
            Config.secilenhastaetayid = hasta.id.toString();
            print("hastaid" + hasta.id.toString());

            return ListView(
              children: [
                Container(
                  color: sfColor,
                  height: context.height * 0.20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                offset: const Offset(0, 3),
                                blurRadius: 8.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            color: const Color.fromARGB(255, 250, 249, 245),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  "https://www.w3schools.com/howto/img_avatar.png"),
                            ),
                            SizedBox(
                              width: context.width * 0.03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hasta Adı: ${hasta.name}",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  "Kimlik Num: ${hasta.identityNumber ?? " Bilgi Bulunamadı"}",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  "Telefon : ${hasta.phone ?? "Telefon Bilgisi Bulunamadı"}",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 14),
                                ),
                                // Text(
                                //   "Hasta Referans :${hasta.referenceName ?? "Referans Bilgisi Bulunamadı"}",
                                //   style: context.textTheme.bodyLarge?.copyWith(
                                //       color: Colors.white, fontSize: 12),
                                // ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ],
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
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
