import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:dental_asistanim/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TedavilerSayfasi extends StatelessWidget {
  const TedavilerSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedTabControl(
                  // Customization of widget
                  radius: const Radius.circular(12),
                  backgroundColor: Colors.grey.shade300,
                  indicatorColor: Colors.orange.shade200,
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  squeezeIntensity: 2,
                  height: 45,
                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  // Options for selection
                  // All specified values will override the [SegmentedTabControl] setting
                  tabs: [
                    SegmentTab(
                        label: 'Devam Edenler',
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                        color: solidColor),
                    SegmentTab(
                      color: solidColor,
                      label: 'Planlananlar',
                    ),
                    SegmentTab(
                      color: solidColor,
                      label: 'Bitenler',
                    ),
                  ],
                ),
              ),
              // Sample pages
              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    DevamEden(),
                    Planlanan(),
                    Biten(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DevamEden extends StatelessWidget {
  const DevamEden({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TedaviCard(
            tarih: "08 - 05 - 2022",
            not: "",
            numara: "26",
            tedaviAdi: " Kanal Tedavisi - Tek Kanal (Dolgu Hariç)",
            hekim: "Önder Akkaya",
            fiyat: "350 ₺",
          ),
        ),
      ],
    );
  }
}

class Planlanan extends StatelessWidget {
  const Planlanan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TedaviCard(
            tarih: "08 - 05 - 2022",
            not: "",
            numara: "26",
            tedaviAdi: " Kanal Tedavisi - Tek Kanal (Dolgu Hariç)",
            hekim: "Önder Akkaya",
            fiyat: "350 ₺",
          ),
        ),
      ],
    );
  }
}

class Biten extends StatelessWidget {
  const Biten({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TedaviCard(
            tarih: "08 - 05 - 2022",
            not: "",
            numara: "26",
            tedaviAdi: " Kanal Tedavisi - Tek Kanal (Dolgu Hariç)",
            hekim: "Önder Akkaya",
            fiyat: "350 ₺",
          ),
        ),
      ],
    );
  }
}

class TedaviCard extends StatelessWidget {
  const TedaviCard({
    super.key,
    required this.tarih,
    required this.not,
    required this.numara,
    required this.tedaviAdi,
    required this.hekim,
    required this.fiyat,
  });
  final String tarih, not, numara, tedaviAdi, hekim, fiyat;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.date_range_outlined,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Tarih : $tarih",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.note_outlined,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Tedavi Notu : $not",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.numbers,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Diş Numarası : $numara",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.home_repair_service_outlined,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Tedavi Adi : $tedaviAdi",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.health_and_safety_outlined,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Hekim : Ömer Akkaya$hekim",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.monetization_on_outlined,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Fiyat : $fiyat",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
