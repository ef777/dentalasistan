import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:dental_asistanim/config.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/models/hastatedaviler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TedavilerSayfasi extends StatefulWidget {
  const TedavilerSayfasi({Key? key}) : super(key: key);

  @override
  State<TedavilerSayfasi> createState() => _TedavilerSayfasiState();
}

List<Hastated> tedaviler = [];

class _TedavilerSayfasiState extends State<TedavilerSayfasi> {
  @override
  void initState() {
    super.initState();

    setState(() {});

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final randevu =
          await Hastatedaviler.hastatedavi(Config.secilenhastaetayid);
      print("tedaviler");
      print(randevu);
      setState(() {
        tedaviler = randevu;
      });
    });

/*     Future.delayed(const Duration(seconds: 1), () {});
 */
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedTabControl(
                  height: 50,
                  // Customization of widget
                  radius: const Radius.circular(12),
                  backgroundColor: Colors.grey.shade300,
                  indicatorColor: Colors.orange.shade200,
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  squeezeIntensity: 2,

                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  // Options for selection
                  // All specified values will override the [SegmentedTabControl] setting
                  tabs: [
                    /*  SegmentTab(
                        label: 'Devam Edenler',
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                        color: solidColor),
                    SegmentTab(
                      color: solidColor,
                      label: 'Planlananlar',
                    ), */
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
                    /*   DevamEden(),
                    Planlanan(), */
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

class Biten extends StatelessWidget {
  const Biten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tedaviler.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: TedaviCard(
            tarih: tedaviler[index].date.toString(),
            not: tedaviler[index].note.toString(),
            numara: tedaviler[index].toothNumber.toString(),
            tedaviAdi: tedaviler[index].treatmentName.toString(),
            hekim: tedaviler[index].doctorName.toString(),
            fiyat: tedaviler[index].treatmentPrice.toString(),
          ),
        );
      },
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
        color: Color.fromARGB(255, 154, 166, 173),
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
