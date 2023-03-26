import 'package:dental_asistanim/etc/custon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../etc/sizeconfig.dart';

class CariHareketler extends StatelessWidget {
  const CariHareketler({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Text(
            "Cari Hesaplar",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Ink(
                  child: Container(
                    width: context.width / 2.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/down3.jpeg",
                            height: 70,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: Text("İndirim Ekle",
                              style: context.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  child: Container(
                    width: context.width / 2.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 39, 10, 229)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Color.fromARGB(255, 41, 23, 240),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/add.jpeg",
                            height: 70,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: Text("Ödeme Ekle",
                              style: context.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: CariCard(
              fiyat: "300",
              not: "",
              tip: "nakit",
              tarih: "09 - 05 - 2022",
            ),
          )
        ],
      ),
    );
  }
}

class CariCard extends StatelessWidget {
  const CariCard({
    super.key,
    required this.tarih,
    required this.not,
    required this.tip,
    required this.fiyat,
  });
  final String tarih, not, tip, fiyat;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
                  Icons.attach_money_sharp,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Ödeme Tutarı : $fiyat",
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
                  Icons.type_specimen_rounded,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Ödeme Tipi : $tip",
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
                  "Ödeme Notu : $not",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
