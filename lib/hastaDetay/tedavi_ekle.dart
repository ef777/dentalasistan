import 'package:dental_asistanim/custon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

class TedaviEkle extends StatefulWidget {
  const TedaviEkle({super.key});

  @override
  State<TedaviEkle> createState() => _TedaviEkleState();
}

class _TedaviEkleState extends State<TedaviEkle> {
  @override
  Widget build(BuildContext context) {
    String _tedaviTi = "";
    String _tedaviSec = "";
    String _hekim = "";
    List<String> _hekimliste = [
      'Seçiniz',
      'Dr. Ali',
    ];
    List<String> _hekimlistedeger = [
      'Seçiniz',
    ];
    List<String> _tedaviSecim = [
      'Seçiniz',
      'Planlanan Tedaviler',
      'Devam Eden Tedaviler',
      'Biten Tedaviler',
    ];
    List<String> _tedaviSecimDeger = [
      'Seçiniz',
    ];
    List<String> _tedaviTipi = [
      'Seçiniz',
      'Planlanan Tedaviler',
      'Devam Eden Tedaviler',
      'Biten Tedaviler',
    ];
    List<String> _tedaviTipideger = [
      'Seçiniz',
    ];
    int? _selectedValue = 1;

    List<DropdownMenuItem<int>> _buildItems() {
      decoration:
      InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: solidColor),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Tedavi Tipi",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
      );
      List<DropdownMenuItem<int>> items = [];
      for (int i = 1; i <= 16; i++) {
        items.add(
          DropdownMenuItem(
            value: i,
            child: Text(i.toString()),
          ),
        );
      }
      return items;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
              labelText: "Tedavi Tipi",
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
                  var index = _tedaviTipi.indexOf(value);
                  _tedaviTi = _tedaviTipideger[index];
                } else {
                  _tedaviTi = "";
                }
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Lütfen Tedavi Seçiniz Seçiniz';
              }
              return null;
            },
            value: _tedaviSec.isEmpty ? null : _tedaviSec,
            items: _tedaviSecim.map((String value) {
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
              labelText: "Tedavi Seçimi",
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
                  var index = _tedaviSecim.indexOf(value);
                  _tedaviTi = _tedaviSecimDeger[index];
                } else {
                  _tedaviTi = "";
                }
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Lütfen tedavi notu giriniz';
              }
              return null;
            },
            maxLines: 1,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: solidColor),
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Tedavi Notu",
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
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
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
              setState(() {});
            },
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Lütfen indirim oranı giriniz';
              }
              return null;
            },
            maxLines: 1,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: solidColor),
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "İndirim Oranı",
              filled: true,
              hintText: " % 0",
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
              setState(() {});
            },
          ),
          SizedBox(
            height: 12,
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Lütfen Hekim Seçiniz';
              }
              return null;
            },
            value: _hekim.isEmpty ? null : _hekim,
            items: _hekimliste.map((String value) {
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
              labelText: "Hekim",
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
                  var index = _hekimliste.indexOf(value);
                  _hekim = _hekimlistedeger[index];
                } else {
                  _hekim = "";
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              title: "Tedavi Ekle",
              onPressed: () {},
              height: 40,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
