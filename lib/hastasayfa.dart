import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dental_asistanim/randevutarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config.dart';

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
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  onChanged: (value) {
                    search(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Arama yapın',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                )
              : Text('Hasta Listesi'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800],
          actions: [
            isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        filteredVeri = veri;
                      });
                    },
                    icon: Icon(Icons.cancel),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: Icon(Icons.search),
                  )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Expanded(
                        child: FutureBuilder(
                      future: hastaal(),
                      builder: (context, snapshot) {
                        print("bu buıild");

                        if (snapshot.hasData) {
                          veri = snapshot.data as List;
                          filteredVeri = veri;

                          var a = filteredVeri as List;
                          print("bu uzunluk");
                          print(a.length);
                          var uzun = a.length;
                          print(veri);
                          print("bu veri");

                          return ListView.builder(
                              itemCount: uzun,
                              itemBuilder: (context, index) {
                                var item = filteredVeri[index];

                                return CustomListTile(
                                    avatar: item['avatar'] == null
                                        ? 'https://www.w3schools.com/howto/img_avatar.png'
                                        : item['avatar'],
                                    name: item['name'],
                                    referans: item['reference_name'] == null
                                        ? "*"
                                        : item['reference_name'],
                                    id: item['id'] == null
                                        ? "0"
                                        : item['id'].toString(),
                                    phone: item['phone'] == null
                                        ? "*"
                                        : item['phone']);
                              });
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Center(
                            child:
                                Container(child: CircularProgressIndicator()));
                      },
                    ))))));
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
                  "ID: " + id,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  "Referans: " + referans,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Telefon: " + phone,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ));
  }
}
