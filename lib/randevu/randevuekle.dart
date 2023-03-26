import 'dart:convert';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/models/doctormodel.dart';
import 'package:dental_asistanim/models/randevudurumlarmodel.dart';
import 'package:dental_asistanim/models/randevudurumlarmodel.dart';
import 'package:dental_asistanim/models/treatmantgrup.dart';
import 'package:dental_asistanim/randevu/randevutarih.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dental_asistanim/models/hastamodel.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../etc/custon_button.dart';

class RandevuEkle extends StatefulWidget {
  @override
  _RandevuEkleState createState() => _RandevuEkleState();
}

class _RandevuEkleState extends State<RandevuEkle> {
  int? _selectedHasta;
  int? _selectedRandevuTuru;

  int? _selectedHekim;
  String _selectedRandevuDurumu = "Seçiniz";
  String _randevuNotu = "";
  List secilitarih = [];
  List<HastaModel> hastaListesi = [];
  DateTime? startDate;
  DateTime? endDate;

  List<randevugrupmodel> randevuTurleri = [];

  List<String> randevuDurumu = [
    'Seçiniz',
    'Hasta Bekleniyor',
    'Hasta Randevuya Geldi',
    'Hasta Randevuyu İptal Etti',
    'Hasta Randevuyu Gelmedi'
  ];

  List<doktorgetmodel> hekimler = [];

  Future<List<rdurum>> randevuduruma() async {
    List<rdurum> rmodels = await Randevudurum.randevudurumlar();
    return rmodels;
  }

  Future<List<doktorgetmodel>> doktor() async {
    try {
      List<doktorgetmodel> doktor = await doktorgetmodel.doktorliste();
      return doktor;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<randevugrupmodel>> randevugrup() async {
    try {
      List<randevugrupmodel> hasta = await randevugrupmodel.randevuturugrup();
      return hasta;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<HastaModel>> hasta() async {
    try {
      List<HastaModel> hasta = await HastaModel.hastagetir();
      return hasta;
    } catch (e) {
      print(e);
      return [];
    }
  }

  randevuekle(hastaid, randevutur, doktor, not, durum, tarih) async {
    TimeOfDay ilksaat = tarih[0];
    var ilksaatsaat = ilksaat.hour.toString();
    var ilksaatdakika = ilksaat.minute.toString();
    print("ilk saat + ${ilksaat}");
    TimeOfDay ikincisaat = tarih[1];
    var ikincisaatsaat = ikincisaat.hour.toString();
    var ikincisaatdakika = ikincisaat.minute.toString();
    print("ikinci saat ${ikincisaat}");
    var date = tarih[2];
    print(date);

    // print("gün ${date}");
    // var gun = date.day.toString();
    // var yil = date.year.toString();
    // var ay = date.month.toString();
    // if (int.parse(ay) < 10) {
    //   ay = "0${ay}";
    // }
    // print("gün ${gun}");
    // print("yıl ${yil}");
    // print("ay ${ay}");

    /*   var formatedgun = tarih[3];
    print("formatedgun ${formatedgun}"); */
    print("giden ilk date = ");
    print("$date ${ilksaatsaat}:${ilksaatdakika}");
    print("giden ikinci date = ");
    print("${date} ${ikincisaatsaat}:${ikincisaatdakika}");
    try {
      var url = Uri.parse('https://demo.dentalasistanim.com/api/appointments');
      var response = await http.post(url, headers: {
        'Accept': 'application/json',
        'branchId': '${Config.subeid}',
        'Authorization': 'Bearer ${Config.token}'
      }, body: {
        "patient_id": "${hastaid.toString()}",
        "doctor_id": "${doktor.toString()}",
        "treatment_group_id": "${randevutur.toString()}",
        /*  "note": "${not.toString()}", */
        "start_at": "${date} ${ilksaatsaat}:${ilksaatdakika}",
        "end_at": "${date} ${ikincisaatsaat}:${ikincisaatdakika}",
      });
      String responseString = response.body;
      Map<String, dynamic> responseData = json.decode(responseString);

      if (response.statusCode == 200) {
        print("başarılı");
        print(responseData);
        return true;
      } else {
        print(responseData);
        print("başarısız");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Hata"),
              content: Text("${responseData["message"]}"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        return false;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            content: Text("${e}"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      print("hataa");

      return false;
    }
  }

  tarihSec() async {
    var result = await Get.to(AppointmentPage());
    return result;
  }

  String _searchText = "";

  List<HastaModel> _searchResult = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    for (var element in randevuDurumu) {
      _listOfRandevuDurum.add(SelectedListItem(name: element));
    }
    super.initState();

    setState(() {
      hastaListesi = [];
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final hastaList = await hasta();
      setState(() {
        hastaListesi = hastaList;
        for (var element in hastaListesi) {
          _listOfHasta.add(SelectedListItem(
              name: element.name, value: element.id.toString()));
        }
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final randevu = await randevugrup();
      setState(() {
        randevuTurleri = randevu;
        for (var e in randevuTurleri) {
          _listOfRandevuType.add(
              SelectedListItem(name: e.name ?? "", value: e.id.toString()));
        }
      });
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final doktorlar = await doktor();
      setState(() {
        hekimler = doktorlar;
        for (var e in hekimler) {
          _listOfDoctor.add(
              SelectedListItem(name: e.name ?? "", value: e.id.toString()));
        }
      });
    });

    var durum = randevuduruma();

    Future.delayed(const Duration(seconds: 1), () {});
  }

  final List<SelectedListItem> _listOfRandevuType = [];
  final List<SelectedListItem> _listOfDoctor = [];
  final List<SelectedListItem> _listOfRandevuDurum = [];
  final List<SelectedListItem> _listOfHasta = [];

  String randevuType = "Randevu Türü Seçiniz";
  String randevuDuruk = "Randevu Durumu Seçiniz ";
  String hastaSec = "Hasta Seçiniz ";

  String doctorList = "Doktor Seçiniz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sfColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Randevu Ekle",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: Image.asset(
                "assets/image2.png",
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
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      _hastaWidget(context),

                      const SizedBox(height: 10),
                      _randevuTypeWidget(context),
                      const SizedBox(height: 10),

                      // DropdownButtonFormField<randevugrupmodel>(
                      //   value: _selectedRandevuTuru,
                      //   items: randevuTurleri.map((randevugrupmodel value) {
                      //     return DropdownMenuItem<randevugrupmodel>(
                      //       value: value,
                      //       child: Text(value.name!),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: solidColor),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     labelText: "Randevu Türü Seçiniz",
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //       vertical: 10,
                      //       horizontal: 16,
                      //     ),
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedRandevuTuru = value;
                      //     });
                      //   },
                      // ),
                      _doctorSelectedWidget(context),

                      const SizedBox(height: 10),
                      // DropdownButtonFormField<doktorgetmodel>(
                      //   value: _selectedHekim,
                      //   items: hekimler.map((doktorgetmodel value) {
                      //     return DropdownMenuItem<doktorgetmodel>(
                      //       value: value,
                      //       child: Text(value.name!),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: solidColor),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     labelText: "Doktor Seçiniz",
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //       vertical: 10,
                      //       horizontal: 16,
                      //     ),
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedHekim = value;
                      //     });
                      //   },
                      // ),
                      _randevuDurumWidget(context),
                      // const SizedBox(height: 16),
                      // DropdownButtonFormField<String>(
                      //   value: _selectedRandevuDurumu.isEmpty
                      //       ? null
                      //       : _selectedRandevuDurumu,
                      //   items: randevuDurumu.map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value.isEmpty ? null : value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: solidColor),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     labelText: "Randevu Durumu Seçiniz",
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //       vertical: 10,
                      //       horizontal: 16,
                      //     ),
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       if (value != null) {
                      //         _selectedRandevuDurumu = value;
                      //       } else {
                      //         _selectedRandevuDurumu = "";
                      //       }
                      //     });
                      //   },
                      // ),

                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Randevu Notu Giriniz",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: solidColor),
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
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        height: 48,
                        onPressed: () async {
                          print("secili tarih bu" + secilitarih.toString());
                          if (secilitarih.isEmpty) {
                            print("tarih boş");
                            secilitarih = await tarihSec();
                            print("işte seçilen tarihler");
                            print(secilitarih);
                            print(secilitarih[1]);
                            print(secilitarih[2]);
                          }
                          if (secilitarih.isNotEmpty) {
                            print("tarih dolu ve gönderiliyor istek");
                            var son = await randevuekle(
                              _selectedHasta!,
                              _selectedRandevuTuru!,
                              _selectedHekim!,
                              "not",
                              _selectedRandevuDurumu,
                              secilitarih,
                            );
                            if (son) {
                              Get.snackbar('Tamam!', 'Randevu kaydedildi!');
                              Navigator.pop(context);
                            } else {
                              Get.snackbar('Hata!', 'Randevu kaydedilmedi!');
                              print("hata ${son.toString()}");
                              secilitarih.clear();
                            }
                          }
                        },
                        title: "Kaydet",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  TextButton _hastaWidget(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.transparent;
              } else {
                return null;
              }
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: solidColor),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hastaSec),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          DropDownState(
            DropDown(
              bottomSheetTitle: Text("Hasta Seçiniz",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              submitButtonChild: const Text(
                'Seç',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: _listOfHasta,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      hastaSec = item.name;
                      _selectedHasta = int.parse(item.value ?? "0");
                    });
                    list.add(item.name);
                  }
                }
              },
              enableMultipleSelection: false,
            ),
          ).showModal(context);
        });
  }

  TextButton _randevuDurumWidget(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.transparent;
              } else {
                return null;
              }
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: solidColor),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(randevuDuruk),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          DropDownState(
            DropDown(
              bottomSheetTitle: Text("Randevu Durumu Seçiniz",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              submitButtonChild: const Text(
                'Seç',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: _listOfRandevuDurum,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      randevuDuruk = item.name;
                      _selectedRandevuDurumu = item.name;
                    });
                    list.add(item.name);
                  }
                }
              },
              enableMultipleSelection: false,
            ),
          ).showModal(context);
        });
  }

  TextButton _doctorSelectedWidget(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.transparent;
              } else {
                return null;
              }
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: solidColor),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(doctorList),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          DropDownState(
            DropDown(
              bottomSheetTitle: Text("Doktor Seçiniz",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              submitButtonChild: const Text(
                'Seç',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: _listOfDoctor,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      doctorList = item.name;
                      _selectedHekim = int.parse(item.value ?? "0");
                    });
                    list.add(item.name);
                  }
                }
              },
              enableMultipleSelection: false,
            ),
          ).showModal(context);
        });
  }

  TextButton _randevuTypeWidget(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.transparent;
              } else {
                return null;
              }
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: solidColor),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(randevuType),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          DropDownState(
            DropDown(
              bottomSheetTitle: Text("Randevu Türü Seçiniz",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              submitButtonChild: const Text(
                'Seç',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: _listOfRandevuType,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      randevuType = item.name;
                      _selectedRandevuTuru = int.parse(item.value ?? "0");
                    });
                    list.add(item.name);
                  }
                }
              },
              enableMultipleSelection: false,
            ),
          ).showModal(context);
        });
  }

  // TextButton _hastaSecWidget(BuildContext context) {
  //   return TextButton(
  //       style: ButtonStyle(
  //         overlayColor: MaterialStateProperty.resolveWith<Color?>(
  //           (Set<MaterialState> states) {
  //             if (states.contains(MaterialState.hovered)) {
  //               return Colors.transparent;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ),
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             side: BorderSide(color: solidColor),
  //           ),
  //         ),
  //         backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
  //           const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(_selectedHasta?.name ?? "Hasta Seçiniz"),
  //           Icon(Icons.arrow_drop_down),
  //         ],
  //       ),
  //       onPressed: () {
  //         showModalBottomSheet(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return StatefulBuilder(
  //                   builder: (BuildContext context, StateSetter setState) {
  //                 return Container(
  //                   padding: const EdgeInsets.all(16),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       TextField(
  //                         decoration: InputDecoration(
  //                           prefixIcon: Icon(Icons.search),
  //                           hintText: 'Hasta ismi...',
  //                         ),
  //                         onChanged: (text) {
  //                           print('Search text: $_searchText');
  //                           print('Search result: $_searchResult');

  //                           setState(() {
  //                             _searchText = text;
  //                             _searchResult = hastaListesi
  //                                 .where((hasta) => hasta.name
  //                                     .toLowerCase()
  //                                     .contains(_searchText.toLowerCase()))
  //                                 .toList();
  //                           });
  //                         },
  //                       ),
  //                       SizedBox(height: 10),
  //                       Expanded(
  //                         child: ListView.builder(
  //                           shrinkWrap: true,
  //                           itemCount: _searchText.isEmpty
  //                               ? hastaListesi.length
  //                               : _searchResult.length,
  //                           itemBuilder: (context, index) {
  //                             final HastaModel hasta = _searchText.isEmpty
  //                                 ? hastaListesi[index]
  //                                 : _searchResult[index];

  //                             return ListTile(
  //                               title: Text(hasta.name),
  //                               selected: _selectedHasta == hasta,
  //                               onTap: () {
  //                                 setState(() {
  //                                   _selectedHasta = hasta;
  //                                 });
  //                                 navigator!.pop();
  //                               },
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               });
  //             });
  //       });
  // }
}
