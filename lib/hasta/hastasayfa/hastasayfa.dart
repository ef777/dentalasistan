import 'dart:convert';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/hasta/hastadetay/hasta_sayfa_detay.dart';
import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:http/http.dart' as http;
import 'package:dental_asistanim/randevu/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';

class HastaSayfa extends StatefulWidget {
  @override
  _HastaSayfaState createState() => _HastaSayfaState();
}

class _HastaSayfaState extends State<HastaSayfa> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List filteredVeri;
  late List veri;

  bool isSearching = false;
  void search(String query) {
    filteredVeri = veri
        .where((element) =>
            element['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {});
  }

  hastaal() async {
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/patients');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Config.token}'
        },
      );
      String responseString = response.body;
      print("bu cevap");

      print(responseString);
      print("bu token");
      print(Config.token);
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        return responseData['data']['data'];
        ;
      } else {
        return "0";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: solidColor,
          child: const Icon(Icons.add),
        ),
        backgroundColor: sfColor,
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  onChanged: (value) {
                    search(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Arama yapın',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                )
              : const Text(''),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // isSearching
            //     ? IconButton(
            //         onPressed: () {
            //           setState(() {
            //             isSearching = false;
            //             filteredVeri = veri;
            //           });
            //         },
            //         // ignore: prefer_const_constructors
            //         icon: Icon(Icons.cancel),
            //       )
            //     : Container(
            //         height: 48,
            //         width: 48,
            //         decoration: const BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Color.fromARGB(72, 245, 245, 245)),
            //         child: IconButton(
            //           onPressed: () {
            //             setState(() {
            //               isSearching = true;
            //             });
            //           },
            //           // ignore: prefer_const_constructors
            //           icon: Icon(Icons.search),
            //         ),
            //       ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(72, 245, 245, 245)),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_active_outlined)),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: Container(
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hasta Listesi",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, right: 22, bottom: 12),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 229, 237, 235),
                          hintText: "Arama Yap",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 22,
                          )),
                    ),
                  ),
                  FutureBuilder(
                    future: hastaal(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        veri = snapshot.data as List;
                        filteredVeri = veri;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: filteredVeri.length,
                            itemBuilder: (context, index) {
                              var item = filteredVeri[index];
                              return Center(child: HastaCard(item: item));
                            },
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            )),
          ],
        ));
  }
}

class HastaCard extends StatelessWidget {
  const HastaCard({
    super.key,
    this.item,
  });
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(HastaDetaySayfa(id: item["id"].toString()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(dfBorderRadius / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hasta Adı : " + item['name'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert_rounded))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 4, right: 23),
                      child: Divider(
                        height: 10,
                        thickness: 1,
                        color: Color.fromARGB(255, 230, 224, 224),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage(item["avatar"] == null
                              ? "https://www.w3schools.com/howto/img_avatar.png"
                              : item["avatar"].toString()),
                          radius: 24.0,
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
                        SizedBox(width: SizeConfig.screenWidth * 0.02),
                        Row(
                          children: [
                            Text(
                              "Telefon : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              item['phone'] ?? "*",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(55, 72, 138, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(dfBorderRadius / 2),
                        topLeft: Radius.circular(dfBorderRadius / 2))),
                height: 130,
                width: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String avatar;
  final String name;
  final String referans;
  final String phone;
  final String id;

  CustomListTile(
      {Key? key,
      required this.avatar,
      required this.name,
      required this.referans,
      required this.phone,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avatar),
              radius: 30.0,
            ),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2.0),
                Text(
                  "ID: $id",
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  "Referans: $referans",
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Telefon: $phone",
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ));
  }
}
