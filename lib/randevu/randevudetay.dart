import 'dart:convert';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dental_asistanim/models/randevumodel.dart';
import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:dental_asistanim/models/randevustatusmodel.dart';
import 'package:dental_asistanim/models/tarihlirandevumodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../const.dart';
import 'package:intl/intl.dart';

import '../etc/custon_button.dart';
import '../models/randevudetaymodel2.dart';

class RandevuDetay extends StatefulWidget {
  RandevuDetay({
    required this.randevuid,
    super.key,
  });
  String randevuid;
  @override
  State<RandevuDetay> createState() => _RandevuDetayState();
}

class _RandevuDetayState extends State<RandevuDetay> {
  //https://demo.dentalasistanim.com/api/appointments?start_at=2022-01-08&end_at=2022-02-10

  DateTime? secilen;
  var gelenid;
  Future<DataRandevu> Randevugetirdetay(id) async {
    try {
      print("data günsüz çekeliyor");
      DataRandevu randevu = await Randevudetay2.randevudetaygetir(id);
      print("çekilen data ");
      print(randevu.id);
      print("tamam?");
      return randevu;
    } catch (e) {
      print("hata randevu");
      return DataRandevu.fromJson({});
    }
  }

  @override
  void initState() {
    super.initState();
    var status = Randevustatus.statusgetir();
    print("statusler ${status}");
    gelenid = widget.randevuid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: solidColor,
        onPressed: () async {
          setState(() {});
        },
        tooltip: 'Aralık Seçin',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ), */
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Randevu Detay",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: sfColor,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox.shrink(),
            elevation: 0,
            backgroundColor: sfColor,
            expandedHeight: SizeConfig.screenHeight * 0.30,
            floating: true,
            pinned: false,
            snap: true,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0),
              background: Image.asset(
                "assets/search-bg.png",
                height: 260,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder(
                    future: Randevugetirdetay(gelenid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var veri;

                        veri = snapshot.data as DataRandevu;
                        print("veri");
                        print(veri.id.toString());
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              DetailsCard(
                                title: "Hasta Adı",
                                veri: veri.patient["name"].toString(),
                                desc: "Randevuya sahip hastanın adı",
                              ),
                              DetailsCard(
                                title: "Randevu Durumu",
                                veri: veri.status.toString(),
                                desc: "",
                              ),
                              DetailsCard(
                                title: "Doktor Adı",
                                veri: veri.doctor.name.toString(),
                                desc: "Randevuya bakacak doktorun adı",
                              ),
                              DetailsCard(
                                title: "Randevu Başlangıç tarihi",
                                veri: DateFormat("yyyy-MM-dd")
                                    .format(veri.startAt)
                                    .toString(),
                                desc: "Randevu tarihi",
                              ),
                              DetailsCard(
                                title: "Randevu Başlangıç saati",
                                veri: DateFormat("HH:mm")
                                    .format(veri.startAt)
                                    .toString(),
                                desc: "Randevu saati",
                              ),
                              DetailsCard(
                                title: "Randevu Bitiş tarihi",
                                veri: DateFormat("yyyy-MM-dd")
                                    .format(veri.endAt)
                                    .toString(),
                                desc: "Randevu tarihi",
                              ),
                              DetailsCard(
                                title: "Randevu Bitiş saati",
                                veri: DateFormat("HH:mm")
                                    .format(veri.endAt)
                                    .toString(),
                                desc: "Randevu saati",
                              ),
                              DetailsCard(
                                title: "Randevu Notu",
                                veri: veri.note.toString(),
                                desc: "Randevuya ait not",
                              ),
                            ],
                          ),
                        );
                        // Column(
                        //   children: [
                        //     Text(veri.patient.toString()),
                        //     Expanded(
                        //       child: Container(
                        //           padding: const EdgeInsets.all(12),
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.white.withOpacity(0.3),
                        //                 offset: const Offset(0, 3),
                        //                 blurRadius: 8.0,
                        //                 spreadRadius: 4.0,
                        //               ),
                        //             ],
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(dfBorderRadius),
                        //               topRight: Radius.circular(dfBorderRadius),
                        //             ),
                        //           ),
                        //           child: Column(children: [
                        //             Text(
                        //               veri.id.toString(),
                        //             ),
                        //             Text(veri.branchId.toString()),
                        //             Text(veri.doctor.toString()),
                        //             Text(veri.appointmentFor.toString()),
                        //             Text(veri.appointmentWith.toString()),
                        //             Text(veri.treatmentGroupId.toString()),
                        //             Text(veri.startAt.toString()),
                        //             Text(veri.endAt.toString()),
                        //             Text(veri.note.toString()),
                        //             Text(veri.status.toString()),
                        //           ])),
                        //     )
                        //   ],
                        // );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              },
              childCount: 1,
            ),
          ),
        ],

        // FutureBuilder(
        //     future: Randevugetirdetay(gelenid),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         var veri;

        //         veri = snapshot.data as DataRandevu;
        //         print("veri");
        //         print(veri.id.toString());
        //         return Column(
        //           children: [
        //             Text(veri.patient.toString()),
        //             Expanded(
        //               child: Container(
        //                   padding: const EdgeInsets.all(12),
        //                   width: double.infinity,
        //                   decoration: BoxDecoration(
        //                     boxShadow: [
        //                       BoxShadow(
        //                         color: Colors.white.withOpacity(0.3),
        //                         offset: const Offset(0, 3),
        //                         blurRadius: 8.0,
        //                         spreadRadius: 4.0,
        //                       ),
        //                     ],
        //                     color: Colors.white,
        //                     borderRadius: BorderRadius.only(
        //                       topLeft: Radius.circular(dfBorderRadius),
        //                       topRight: Radius.circular(dfBorderRadius),
        //                     ),
        //                   ),
        //                   child: Column(children: [
        //                     Text(
        //                       veri.id.toString(),
        //                     ),
        //                     Text(veri.branchId.toString()),
        //                     Text(veri.doctor.toString()),
        //                     Text(veri.appointmentFor.toString()),
        //                     Text(veri.appointmentWith.toString()),
        //                     Text(veri.treatmentGroupId.toString()),
        //                     Text(veri.startAt.toString()),
        //                     Text(veri.endAt.toString()),
        //                     Text(veri.note.toString()),
        //                     Text(veri.status.toString()),
        //                   ])),
        //             )
        //           ],
        //         );
        //       } else {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     }),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.title,
    required this.desc,
    required this.veri,
  });
  final String title;
  final String desc;
  final String veri;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 128, 110, 216).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: const Color.fromARGB(255, 249, 250, 250),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Image.asset(
              "assets/detay2.png",
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  desc,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            const Spacer(),
            Text(veri),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
