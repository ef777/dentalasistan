import 'dart:convert';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dental_asistanim/randevumodel.dart';
import 'package:dental_asistanim/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config.dart';
import 'const.dart';
import 'package:intl/intl.dart';

import 'custon_button.dart';

class YaklasanRandevu extends StatefulWidget {
  const YaklasanRandevu({super.key});

  @override
  State<YaklasanRandevu> createState() => _YaklasanRandevuState();
}

class _YaklasanRandevuState extends State<YaklasanRandevu> {
  //https://demo.dentalasistanim.com/api/appointments?start_at=2022-01-08&end_at=2022-02-10

  DateTime? startDate;
  DateTime? endDate;

  Future<List<Datum>> randdatacek() async {
    try {
      print("data çekeliuot");
      List<Datum> randevu = await Randevusayfa.randevugetir();
      print("çekilen data ");
      print(randevu[0].id);
      print("tamam?");
      return randevu;
    } catch (e) {
      print("hata randevu");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: solidColor,
        onPressed: () {
          showCustomDateRangePicker(
            primaryColor: solidColor,
            backgroundColor: solidColor,
            context,
            dismissible: true,
            minimumDate: DateTime.now().subtract(const Duration(days: 30)),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            endDate: endDate,
            startDate: startDate,
            onApplyClick: (start, end) {
              setState(() {
                endDate = end;
                startDate = start;
              });
            },
            onCancelClick: () {
              setState(() {
                endDate = null;
                startDate = null;
              });
            },
          );
        },
        tooltip: 'choose date Range',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
      backgroundColor: sfColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Yaklaşan Randevu",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: randdatacek(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var veri = snapshot.data as List<Datum>;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: Image.asset(
                      "assets/yaklasan.png",
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
                      child: ListView.builder(
                        itemCount: veri.length,
                        itemBuilder: (context, index) {
                          return RandevuCard(
                            hastaAdi: veri[index].patient?.name == null
                                ? "Hasta adı yok!"
                                : veri[index].patient!.name,
                            doktorAdi: veri[index].doctor.name,
                            randevuTarihi: veri[index].startAt.toString(),
                            randevuSaati: veri[index].startAt.hour.toString() +
                                ":" +
                                veri[index].startAt.minute.toString(),
                          );
                        },
                      ),
                    ),
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

class RandevuCard extends StatelessWidget {
  const RandevuCard({
    super.key,
    required this.hastaAdi,
    required this.doktorAdi,
    required this.randevuTarihi,
    required this.randevuSaati,
  });
  final String hastaAdi, doktorAdi;
  final String randevuTarihi, randevuSaati;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 148,
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
                        "Hasta Adı : $hastaAdi",
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
                  Row(
                    children: [
                      const Icon(Icons.timer_sharp),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        randevuTarihi,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        randevuSaati,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
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
                        backgroundImage: const NetworkImage(
                            "https://www.w3schools.com/howto/img_avatar.png"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doktorAdi,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Diş Hekimi  ",
                            style: Theme.of(context).textTheme.bodySmall,
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
              height: 148,
              width: 9,
            ),
          ),
        ],
      ),
    );
  }
}
