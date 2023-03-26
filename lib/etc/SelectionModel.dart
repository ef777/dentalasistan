// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter_named/font_awesome_flutter_named.dart';

class SelectionCardModel {
  String image;
  String title;
  SelectionCardModel({
    required this.image,
    required this.title,
  });
}

List<SelectionCardModel> selectionCardModelList = [
  SelectionCardModel(
      image: "assets/date_record_image.jpg", title: "Kayıtlı Randevular"),
  SelectionCardModel(image: "assets/add_date.jpg", title: "Randevu Ekle"),
  SelectionCardModel(image: "assets/list_ patient.jpg", title: "Hasta Listesi"),
  SelectionCardModel(image: "assets/add_ patient.png", title: "Hasta Ekle"),
];

class SelectionCardModel2 {
  String title;
  String desc;
  Color color;
  Widget iconWidget;
  SelectionCardModel2({
    required this.title,
    required this.desc,
    required this.color,
    required this.iconWidget,
  });
}

List<SelectionCardModel2> selectionCardModelList2 = [
  SelectionCardModel2(
      iconWidget: FaIcon(
        faIconNameMapping['clipboard']!,
        size: 32,
        color: Colors.white,
      ),
      title: "Kayıtlı Hastalar",
      desc: "Kayıtlı hastaları ve yaklaşan randevuları görüntüleyebilirsin",
      color: Colors.red),
  SelectionCardModel2(
      iconWidget: const Icon(
        Icons.date_range_outlined,
        size: 32,
        color: Colors.white,
      ),
      title: "Randevu Ekle ",
      desc: "Yeni randevular oluşturabilirsins",
      color: Colors.yellow),
  SelectionCardModel2(
      iconWidget: const Icon(
        Icons.recent_actors_outlined,
        size: 32,
        color: Colors.white,
      ),
      title: "Hasta Listesi ",
      desc: "Kayıtlı hastaların listesini burada bulabilirsin",
      color: Colors.green),
  SelectionCardModel2(
      iconWidget: const Icon(
        Icons.add,
        size: 32,
        color: Colors.white,
      ),
      title: "Hasta Ekle ",
      desc: "Kayıtlı hastaların yeni bir hasta ekleyebilirsin",
      color: Colors.purple)
];
//Icon(Icons.recent_actors_outlined),