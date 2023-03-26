import 'package:dental_asistanim/etc/SelectionModel.dart';
import 'package:dental_asistanim/const.dart';
import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:dental_asistanim/hasta/hastasayfa/hastaekle.dart';
import 'package:dental_asistanim/randevu/randevuekle.dart';
import 'package:dental_asistanim/randevu/yaklasan_randevu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config.dart';
import 'hasta/hastasayfa/hastasayfa.dart';

class HomeView extends StatefulWidget {
  late String name;

  HomeView({super.key, required this.name});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
          ],
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: sfColor,
        ),
        body: ListView(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  color: sfColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue, // Solid renk
                      backgroundImage:
                          const AssetImage('assets/avatarImage.png'),
                      radius: 45.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 11, 67, 12),
                            width: 3.0, // Kenarlık kalınlığı
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Doctor : Önder Akkaya",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: [
                  // const Divider(
                  //   height: 0.2,
                  //   thickness: 1,
                  // ),
                  // SelectionCard(
                  //   onPressed: () {
                  //     Get.to(YaklasanRandevu());
                  //   },
                  //   size: size,
                  //   selectionCardModel: selectionCardModelList[0],
                  // ),
                  // SelectionCard(
                  //   onPressed: () {
                  //     Get.to(RandevuEkle());
                  //   },
                  //   size: size,
                  //   selectionCardModel: selectionCardModelList[1],
                  // ),
                  // SelectionCard(
                  //   onPressed: () {
                  //     Get.to(HastaSayfa());
                  //   },
                  //   size: size,
                  // selectionCardModel: selectionCardModelList[2],
                  // ),
                  // SelectionCard(
                  //   onPressed: () {
                  //     Get.to(Hastaekle());
                  //   },
                  //   size: size,
                  //   selectionCardModel: selectionCardModelList[3],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MenuCard(
                        onTap: () => Get.to(const YaklasanRandevu()),
                        selectionCardModel2: selectionCardModelList2[0],
                      ),
                      MenuCard(
                        onTap: () => Get.to(RandevuEkle()),
                        selectionCardModel2: selectionCardModelList2[1],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MenuCard(
                        onTap: () => Get.to(HastaSayfa()),
                        selectionCardModel2: selectionCardModelList2[2],
                      ),
                      MenuCard(
                        onTap: () => Get.to(Hastaekle()),
                        selectionCardModel2: selectionCardModelList2[3],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.selectionCardModel2,
    required this.onTap,
  });
  final SelectionCardModel2 selectionCardModel2;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: SizedBox(
          width: SizeConfig.screenWidth * 0.48,
          height: SizeConfig.screenWidth * 0.48,
          child: Stack(children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.screenWidth * 0.42,
                height: SizeConfig.screenWidth * 0.42,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      selectionCardModel2.title,
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      selectionCardModel2.desc,
                      style: context.textTheme.labelMedium
                          ?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 22,
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: selectionCardModel2.color.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: selectionCardModel2.color,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(child: selectionCardModel2.iconWidget)),
            )
          ]),
        ),
      ),
    );
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
      /*      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, */
      children: [
        SizedBox(
          height: size.height * 0.08,
        ),
        Column(
          children: [
            SizedBox(
                height: size.height * 0.08,
                child: CircleAvatar(
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
                )),
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
              Config.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
            ),
            Text(
              "Admin",
              style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.w700, color: Colors.white60),
            )
          ],
        )
      ],
    );
  }
}
