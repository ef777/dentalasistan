import 'dart:convert';

import 'package:dental_asistanim/config.dart';
import 'package:dental_asistanim/etc/custon_button.dart';
import 'package:dental_asistanim/models/doctormodel.dart';
import 'package:dental_asistanim/models/treatmantgrup.dart';
import 'package:dental_asistanim/models/treatmantsmodel.dart';
import 'package:dental_asistanim/models/treatmentlist.dart';
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
        'https://demo.dentalasistanim.com/api/patients/${hastaid}/examinations?doctorId=${doctorid}&priceListId=${utarife}&treatmentId=${tedaviid}&toothNumbers[]=${disno}&treatmentPlanningId=${islemtipid}&canals[]=');
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
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final islemtip1 = await Treatmentlist.treatmentlistgetir();
      setState(() {
        islemtip = islemtip1;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final islemtip1 = await randevugrupmodel.randevuturugrup();
      setState(() {
        randevuturu = islemtip1;
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final doktorlar = await doktorgetmodel.doktorliste();
      setState(() {
        doktors = doktorlar;
      });
    });
  }

  List<doktorgetmodel> doktors = [];
  doktorgetmodel? secilendoktor;
  var disno;
  String _searchText = "";
  var _searchResult;
  treatmentlist? secilentipislem;
  List<treatmentlist>? islemtip;
  List<randevugrupmodel>? randevuturu;
  randevugrupmodel? secilentiprandevu;

  List<Treatments>? tiptedaviler;
  Treatments? secilentiptedaviler;
  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<treatmentlist>(
                value: secilentipislem,
                items: islemtip?.map((treatmentlist value) {
                  return DropdownMenuItem<treatmentlist>(
                    value: value,
                    child: Text(value.name!),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: solidColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Ücret Tarifesi Seçiniz",
                  filled: true,
                  fillColor: Colors.white,
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
                    secilentipislem = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen Tedavi Tipi Seçiniz';
                  }
                  return null;
                },
                value: _tedaviTi.isEmpty ? null : _tedaviTi,
                items: _tedaviTipi.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isEmpty ? null : value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: solidColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "İşlem Seçimi",
                  filled: true,
                  fillColor: Colors.white,
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
                    if (value != null) {
                      _selectedValue = _tedaviTipi.indexOf(value);
                      _tedaviTi = _tedaviTipideger[_selectedValue];
                    } else {
                      _tedaviTi = "";
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<randevugrupmodel>(
                value: secilentiprandevu,
                items: randevuturu?.map((randevugrupmodel value) {
                  return DropdownMenuItem<randevugrupmodel>(
                    value: value,
                    child: Text(value.name!),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: solidColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Tedavi Grup",
                  filled: true,
                  fillColor: Colors.white,
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
                    secilentiprandevu = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(secilentiptedaviler?.title ?? "Tedavi Seçiniz"),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return FutureBuilder(
                                future: Treatments.treatmentsgetir(
                                    secilentipislem!.id, secilentiprandevu!.id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    tiptedaviler =
                                        snapshot.data as List<Treatments>;
                                    print("builde gelen data + $tiptedaviler");
                                    return Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.search),
                                              hintText: 'Tedavi seç...',
                                            ),
                                            onChanged: (text) {
                                              print(
                                                  'Search text: $_searchText');
                                              print(
                                                  'Search result: $_searchResult');

                                              setState(() {
                                                _searchText = text;
                                                _searchResult = tiptedaviler!
                                                    .where((tiptedaviler) =>
                                                        tiptedaviler!.title!
                                                            .toLowerCase()
                                                            .contains(_searchText
                                                                .toLowerCase()))
                                                    .toList();
                                              });
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          Expanded(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _searchText.isEmpty
                                                  ? tiptedaviler!.length
                                                  : _searchResult.length,
                                              itemBuilder: (context, index) {
                                                final Treatments hasta =
                                                    _searchText.isEmpty
                                                        ? tiptedaviler![index]
                                                        : _searchResult[index];

                                                return ListTile(
                                                  title: Text(hasta.title!),
                                                  selected:
                                                      secilentiptedaviler ==
                                                          hasta,
                                                  onTap: () {
                                                    setState(() {
                                                      secilentiptedaviler =
                                                          hasta;
                                                    });
                                                    navigator!.pop();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          });
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
                  filled: true,
                  fillColor: Colors.white,
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
              SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {},
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(secilentiptedaviler?.price ?? "Fiyat Boş"),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              DropdownButtonFormField<doktorgetmodel>(
                value: secilendoktor,
                items: doktors?.map((doktorgetmodel value) {
                  return DropdownMenuItem<doktorgetmodel>(
                    value: value,
                    child: Text(value.name!),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: solidColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Seçilen Doktor",
                  filled: true,
                  fillColor: Colors.white,
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
                    secilendoktor = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  title: "Tedavi Ekle",
                  onPressed: () {
                    tedaviekle(
                        Config.secilenhastaetayid,
                        secilendoktor!.id,
                        secilentipislem!.id,
                        secilentiptedaviler!.id,
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
}
