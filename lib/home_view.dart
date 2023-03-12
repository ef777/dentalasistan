import 'package:dental_asistanim/SelectionModel.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/hastaekle.dart';
import 'package:dental_asistanim/randevuekle.dart';
import 'package:dental_asistanim/selectionCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hastasayfa.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: sfColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const ProfileAppbar(),
                        const Divider(
                          height: 0.2,
                          thickness: 1,
                        ),
                        SelectionCard(
                          onPressed: () {},
                          size: size,
                          selectionCardModel: selectionCardModelList[0],
                        ),
                        SelectionCard(
                          onPressed: () {
                            Get.to(RandevuEkle());
                          },
                          size: size,
                          selectionCardModel: selectionCardModelList[1],
                        ),
                        SelectionCard(
                          onPressed: () {
                            Get.to(HastaSayfa());
                          },
                          size: size,
                          selectionCardModel: selectionCardModelList[2],
                        ),
                        SelectionCard(
                          onPressed: () {
                            Get.to(Hastaekle());
                          },
                          size: size,
                          selectionCardModel: selectionCardModelList[3],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue, // Solid renk
              backgroundImage: const AssetImage('assets/avatarImage.png'),
              radius: 45.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: solidColor,
                    width: 3.0, // Kenarlık kalınlığı
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              width: 58,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dfBorderRadius / 2),
                color: solidColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          children: [
            Text(
              adminName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              "Admin",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w700),
            )
          ],
        )
      ],
    );
  }
}
