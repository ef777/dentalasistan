import 'package:dental_asistanim/etc/custon_button.dart';
import 'package:flutter/material.dart';

import '../../etc/sizeconfig.dart';

class CariHareketler extends StatelessWidget {
  const CariHareketler({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Cari Hesaplar",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            CustomButton(
              title: "İndirim Ekle",
              onPressed: () {},
              height: 40,
              color: Color.fromARGB(255, 57, 184, 157),
            ),
            CustomButton(
              title: "Ödeme Ekle",
              onPressed: () {},
              height: 40,
              color: Color.fromARGB(255, 3, 16, 155),
            )
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
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
