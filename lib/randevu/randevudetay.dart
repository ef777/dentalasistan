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
      backgroundColor: sfColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Randevu Detay",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: Randevugetirdetay(gelenid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var veri;

              veri = snapshot.data as DataRandevu;
              print("veri");
              print(veri.id.toString());
              return Column(
                children: [
                  Text(veri.patient.toString()),
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
                        child: Column(children: [
                          Text(
                            veri.id.toString(),
                          ),
                          Text(veri.branchId.toString()),
                          Text(veri.doctor.toString()),
                          Text(veri.appointmentFor.toString()),
                          Text(veri.appointmentWith.toString()),
                          Text(veri.treatmentGroupId.toString()),
                          Text(veri.startAt.toString()),
                          Text(veri.endAt.toString()),
                          Text(veri.note.toString()),
                          Text(veri.status.toString()),
                        ])),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
