import 'dart:convert';

import 'package:dental_asistanim/config.dart';
import 'package:dental_asistanim/etc/custon_button.dart';
import 'package:dental_asistanim/models/doctormodel.dart';
import 'package:dental_asistanim/models/treatmantgrup.dart';
import 'package:dental_asistanim/models/treatmantsmodel.dart';
import 'package:dental_asistanim/models/treatmentlist.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../const.dart';

class TedaviEkle extends StatefulWidget {
  TedaviEkle({super.key});

  @override
  State<TedaviEkle> createState() => _TedaviEkleState();
}

Future<bool> tedaviekle(
    hastaid, doctorid, utarife, tedaviid, disno, islemtipid) async {
  try {
    var url = Uri.parse(
        'https://demo.dentalasistanim.com/api/patients/$hastaid/examinations?doctorId=$doctorid&priceListId=$utarife&treatmentId=$tedaviid&toothNumbers[]=$disno&treatmentPlanningId=$islemtipid&canals[]=');
    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Config.token}'
      },
    );
    String responseString = response.body;
    Map<String, dynamic> responseData = json.decode(responseString);

    if (response.statusCode == 200) {
      print("başarılı");
      print(responseData);
      return true;
    } else {
      print(response.body);
      print(response.statusCode);
      print("başarısız");
      print(url);
      return false;
    }
  } catch (e) {
    print(e);
    print("hataa");
    return false;
  }
}

class _TedaviEkleState extends State<TedaviEkle> {
  @override
  initState() {
    for (var element in _tedaviTipi) {
      _listOfIslem.add(SelectedListItem(name: element));
    }
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final islemtip1 = await Treatmentlist.treatmentlistgetir();
      setState(() {
        islemtip = islemtip1;
        for (var element in islemtip!) {
          _listOfTarife.add(SelectedListItem(
              name: element.name, value: element.id.toString()));
        }
        print(_listOfTarife);
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final islemtip1 = await randevugrupmodel.randevuturugrup();
      setState(() {
        randevuturu = islemtip1;
        for (var element in randevuturu!) {
          _listOfTedavi.add(SelectedListItem(
              name: element.name.toString(), value: element.id.toString()));
        }
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final doktorlar = await doktorgetmodel.doktorliste();
      setState(() {
        doktors = doktorlar;
        for (var element in doktors) {
          _listOfDoctor.add(SelectedListItem(
              name: element.name, value: element.id.toString()));
        }
      });
    });
  }

  List<doktorgetmodel> doktors = [];
  int secilendoktor = 0;
  String money = "0";
  var disno;
  String _searchText = "";
  var _searchResult;
  int secilentipislem = 0;
  List<treatmentlist>? islemtip;
  List<randevugrupmodel>? randevuturu;

  randevugrupmodel? secilentiprandevu;

  List<Treatments>? tiptedaviler;
  int secilentiptedaviler = 0;
  final List<SelectedListItem> _listOfTarife = [];
  final List<SelectedListItem> _listOfTedavi = [];
  final List<SelectedListItem> _listOfDoctor = [];

  final List<SelectedListItem> _listOfIslem = [];

  String randevuType = "Bir İşlem Seçiniz";
  String randevuPrice = "Ücret Tarifesi Seçiniz";
  String tedavi = "Bir Tedavi Seçiniz";
  String doctorList = "Doktor Seçiniz";
  String _tedaviTi = "";

  List<String> _tedaviTipi = [
    'Diagnoz',
    'Planlama 1',
    'Planlama 2',
    'Planlama 3',
    'Planlama 4',
    'Planlama 5',
    'Planlama 6',
    'Tedavi',
  ];
  List<String> _tedaviTipideger = [
    'Seçiniz',
  ];

  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tedavi Ekle",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              _tarifeWidget(context),
              // DropdownButtonFormField<treatmentlist>(
              //   value: secilentipislem,
              //   items: islemtip?.map((treatmentlist value) {
              //     return DropdownMenuItem<treatmentlist>(
              //       value: value,
              //       child: Text(value.name!),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: solidColor),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     labelText: "Ücret Tarifesi Seçiniz",
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
              //       secilentipislem = value;
              //     });
              //   },
              // ),

              const SizedBox(
                height: 12,
              ),
              _islemWidget(context),
              // DropdownButtonFormField<String>(
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Lütfen Tedavi Tipi Seçiniz';
              //     }
              //     return null;
              //   },
              //   value: _tedaviTi.isEmpty ? null : _tedaviTi,
              //   items: _tedaviTipi.map((String value) {
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
              //     labelText: "İşlem Seçimi",
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
              //         _selectedValue = _tedaviTipi.indexOf(value);
              //         _tedaviTi = _tedaviTipideger[_selectedValue];
              //       } else {
              //         _tedaviTi = "";
              //       }
              //     });
              //   },
              // ),

              const SizedBox(
                height: 12,
              ),
              _tedaviWidget(context),
              // DropdownButtonFormField<randevugrupmodel>(
              //   value: secilentiprandevu,
              //   items: randevuturu?.map((randevugrupmodel value) {
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
              //     labelText: "Tedavi Grup",
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
              //       secilentiprandevu = value;
              //     });
              //   },
              // ),
              const SizedBox(
                height: 12,
              ),
              // TextButton(
              //     style: ButtonStyle(
              //       overlayColor: MaterialStateProperty.resolveWith<Color?>(
              //         (Set<MaterialState> states) {
              //           if (states.contains(MaterialState.hovered)) {
              //             return Colors.transparent;
              //           } else {
              //             return null;
              //           }
              //         },
              //       ),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           side: BorderSide(color: solidColor),
              //         ),
              //       ),
              //       backgroundColor:
              //           MaterialStateProperty.all<Color>(Colors.white),
              //       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              //         const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(secilentiptedaviler?.title ?? "Tedavi Seçiniz"),
              //         Icon(Icons.arrow_drop_down),
              //       ],
              //     ),
              //     onPressed: () {
              //       showModalBottomSheet(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return StatefulBuilder(builder:
              //                 (BuildContext context, StateSetter setState) {
              //               return FutureBuilder(
              //                   future: Treatments.treatmentsgetir(
              //                       secilentipislem!.id, secilentiprandevu!.id),
              //                   builder: (context, snapshot) {
              //                     if (snapshot.hasData) {
              //                       tiptedaviler =
              //                           snapshot.data as List<Treatments>;
              //                       print("builde gelen data + $tiptedaviler");
              //                       return Container(
              //                         padding: const EdgeInsets.all(16),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             TextField(
              //                               decoration: InputDecoration(
              //                                 prefixIcon: Icon(Icons.search),
              //                                 hintText: 'Tedavi seç...',
              //                               ),
              //                               onChanged: (text) {
              //                                 print(
              //                                     'Search text: $_searchText');
              //                                 print(
              //                                     'Search result: $_searchResult');

              //                                 setState(() {
              //                                   _searchText = text;
              //                                   _searchResult = tiptedaviler!
              //                                       .where((tiptedaviler) =>
              //                                           tiptedaviler!.title!
              //                                               .toLowerCase()
              //                                               .contains(_searchText
              //                                                   .toLowerCase()))
              //                                       .toList();
              //                                 });
              //                               },
              //                             ),
              //                             SizedBox(height: 10),
              //                             Expanded(
              //                               child: ListView.builder(
              //                                 shrinkWrap: true,
              //                                 itemCount: _searchText.isEmpty
              //                                     ? tiptedaviler!.length
              //                                     : _searchResult.length,
              //                                 itemBuilder: (context, index) {
              //                                   final Treatments hasta =
              //                                       _searchText.isEmpty
              //                                           ? tiptedaviler![index]
              //                                           : _searchResult[index];

              //                                   return ListTile(
              //                                     title: Text(hasta.title!),
              //                                     selected:
              //                                         secilentiptedaviler ==
              //                                             hasta,
              //                                     onTap: () {
              //                                       setState(() {
              //                                         secilentiptedaviler =
              //                                             hasta;
              //                                       });
              //                                       navigator!.pop();
              //                                     },
              //                                   );
              //                                 },
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       );
              //                     } else {
              //                       return Center(
              //                         child: CircularProgressIndicator(),
              //                       );
              //                     }
              //                   });
              //             });
              //           });
              //     }),

              SizedBox(
                height: 44,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen diş seçiniz';
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: solidColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Diş seçimi  ",
                    labelStyle: context.textTheme.bodyLarge
                        ?.copyWith(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: solidColor),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      disno = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 44,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen tedavi ücreti giriniz';
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: solidColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Tedavi Ücreti",
                    labelStyle: context.textTheme.bodyLarge
                        ?.copyWith(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: solidColor),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      money = value.toString();
                    });
                  },
                ),
              ),
              // TextButton(
              //   onPressed: () {},
              //   style: ButtonStyle(
              //     overlayColor: MaterialStateProperty.resolveWith<Color?>(
              //       (Set<MaterialState> states) {
              //         if (states.contains(MaterialState.hovered)) {
              //           return Colors.transparent;
              //         } else {
              //           return null;
              //         }
              //       },
              //     ),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         side: BorderSide(color: solidColor),
              //       ),
              //     ),
              //     backgroundColor:
              //         MaterialStateProperty.all<Color>(Colors.white),
              //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       // Text(secilentiptedaviler?.price ?? "Fiyat Boş"),
              //       Icon(Icons.arrow_drop_down),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 12,
              ),
              _doctorWidget(context),
              // DropdownButtonFormField<doktorgetmodel>(
              //   value: secilendoktor,
              //   items: doktors?.map((doktorgetmodel value) {
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
              //     labelText: "Seçilen Doktor",
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
              //       secilendoktor = value;
              //     });
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  title: "Tedavi Ekle",
                  onPressed: () {
                    tedaviekle(
                        Config.secilenhastaetayid,
                        secilendoktor,
                        randevuType,
                        secilentiptedaviler,
                        disno,
                        _selectedValue);
                  },
                  height: 40,
                  width: double.infinity,
                ),
              )
            ],
          ),
        ));
  }

  TextButton _doctorWidget(BuildContext context) {
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
                      secilendoktor = int.parse(item.value ?? "0");
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

  TextButton _tedaviWidget(BuildContext context) {
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
            Text(tedavi),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          DropDownState(
            DropDown(
              bottomSheetTitle: Text("Bir Tedavi Seçiniz",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              submitButtonChild: const Text(
                'Seç',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: _listOfTedavi,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      tedavi = item.name;
                      secilentiptedaviler = int.parse(item.value.toString());
                      // secilentipislem =
                      //     int.parse(item.value.toString());
                      //  _selectedRandevuDurumu = item.name;
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

  TextButton _islemWidget(BuildContext context) {
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
            const Icon(Icons.arrow_drop_down),
          ],
        ),
        onPressed: () {
          DropDownState(
            DropDown(
              bottomSheetTitle: Text("Bir İşlem Seçiniz",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              submitButtonChild: const Text(
                'Seç',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: _listOfIslem,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      randevuType = item.name;
                      // secilentipislem =
                      //     int.parse(item.value.toString());
                      //  _selectedRandevuDurumu = item.name;
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

  TextButton _tarifeWidget(BuildContext context) {
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
            Text(randevuPrice),
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
              data: _listOfTarife,
              selectedItems: (List<dynamic> selectedList) {
                List<String> list = [];
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    setState(() {
                      randevuPrice = item.name;
                      secilentipislem = int.parse(item.value.toString());
                      //  _selectedRandevuDurumu = item.name;
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
}
