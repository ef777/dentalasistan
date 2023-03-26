import 'dart:convert';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dental_asistanim/models/randevumodel.dart';
import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:dental_asistanim/models/tarihlirandevumodel.dart';
import 'package:dental_asistanim/randevu/randevudetay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../const.dart';
import 'package:intl/intl.dart';

import '../etc/custon_button.dart';

class YaklasanRandevu extends StatefulWidget {
  const YaklasanRandevu({super.key});

  @override
  State<YaklasanRandevu> createState() => _YaklasanRandevuState();
}

class _YaklasanRandevuState extends State<YaklasanRandevu> {
  //https://demo.dentalasistanim.com/api/appointments?start_at=2022-01-08&end_at=2022-02-10

  DateTime? startDate;
  DateTime? endDate;
  DateTime? secilen;
  var secilenstring;

  Future<List<Datum>> randdatacek() async {
    try {
      print("data günsüz çekeliyor");
      List<Datum> randevu = await Randevusayfa.randevugetir();
      print("liste uzunluğu ${randevu.length}");
      print("çekilen data ");
      print(randevu[0].id);
      print("tamam?");
      return randevu;
    } catch (e) {
      print("hata randevu");
      return [];
    }
  }

  Future<List<Datum2>> tarihliranddatacek(tarih) async {
    try {
      print("tarihli çekiliyor");
      List<Datum2> randevu = await TarihliRandevu.tarihlirandevugetir(tarih);
      print("liste uzunluğu ${randevu.length}");
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: solidColor,
      //   onPressed: () async {
      //     final DateTime? picked = await showRoundedDatePicker(
      //       context: context,
      //       initialDate: DateTime.now(),
      //       firstDate: DateTime(DateTime.now().year - 1),
      //       lastDate: DateTime(DateTime.now().year + 1),
      //       borderRadius: 16,
      //     );

      //     setState(() {
      //       secilen = picked;

      //       if (secilen!.month < 10 && secilen!.day < 10) {
      //         secilenstring =
      //             "${secilen!.year}-0${secilen!.month}-0${secilen!.day}";
      //       }
      //       if (secilen!.month < 10 && secilen!.day > 10) {
      //         secilenstring =
      //             "${secilen!.year}-0${secilen!.month}-${secilen!.day}";
      //       }
      //       if (secilen!.month > 10 && secilen!.day < 10) {
      //         secilenstring =
      //             "${secilen!.year}-${secilen!.month}-0${secilen!.day}";
      //       }
      //       if (secilen!.month > 10 && secilen!.day > 10) {
      //         secilenstring =
      //             "${secilen!.year}-${secilen!.month}-${secilen!.day}";
      //       }
      //       //
      //     });
      //   },
      //   tooltip: 'Aralık Seçin',
      //   child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      // ),
      backgroundColor: sfColor,
      appBar: CalendarAgenda(
        backgroundColor: sfColor,
        fullCalendar: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        locale: "tr",
        appbar: true,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 15)),
        lastDate: DateTime.now().add(Duration(days: 15)),
        onDateSelected: (date) async {
          print(date);

          setState(() {
            secilen = date;

            if (secilen!.month < 10 && secilen!.day < 10) {
              secilenstring =
                  "${secilen!.year}-0${secilen!.month}-0${secilen!.day}";
            }
            if (secilen!.month < 10 && secilen!.day > 10) {
              secilenstring =
                  "${secilen!.year}-0${secilen!.month}-${secilen!.day}";
            }
            if (secilen!.month > 10 && secilen!.day < 10) {
              secilenstring =
                  "${secilen!.year}-${secilen!.month}-0${secilen!.day}";
            }
            if (secilen!.month > 10 && secilen!.day > 10) {
              secilenstring =
                  "${secilen!.year}-${secilen!.month}-${secilen!.day}";
            }
            //
          });
        },
      ),
      body: FutureBuilder(
          future: secilen.isNull
              ? randdatacek()
              : tarihliranddatacek(secilenstring),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var veri = [];
              if (secilen.isNull) {
                veri = snapshot.data as List<Datum>;
              } else {
                veri = snapshot.data as List<Datum2>;
              }

              print("buildde veri uzunluğu ${veri.length}");
              return Column(
                children: [
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
                          if (veri[index]
                                  .startAt
                                  .isBefore(startDate ?? DateTime.now()) &&
                              veri[index].startAt.isBefore(endDate ??
                                  DateTime.now()
                                      .add(const Duration(days: 1)))) {
                            return const SizedBox.shrink();
                          }
                          return RandevuCard(
                            randevuid: veri[index].id.toString(),
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
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
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
    required this.randevuid,
  });
  final String hastaAdi, doktorAdi, randevuid;
  final String randevuTarihi, randevuSaati;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(RandevuDetay(
            randevuid: randevuid,
          ));
        },
        child: Padding(
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
        ));
  }
}
