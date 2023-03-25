// To parse this JSON data, do
//
//     final treatments = treatmentsFromJson(jsonString);
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';

class Treatments {
  Treatments({
    this.id,
    this.title,
    this.applicablePlace,
    this.price,
    this.currency,
    this.canalCount,
    this.isActive,
  });

  static Future<List<Treatments>> treatmentsgetir(
      pricelist, treatmenttype) async {
    try {
      var url = Uri.parse(
          'https://demo.dentalasistanim.com/api/treatments?currencyId=TRY&priceListId=${pricelist}&treatmentTypeId=${treatmenttype}');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Config.token}'
        },
      );

      if (response.statusCode == 200) {
        String responseString = response.body;
        print("bu cevap");
        print(responseString);

        List<dynamic> responseData = json.decode(responseString);

        print("bu treatments");
        print(responseData);
        print("treatmants geldi");

        List<Treatments> treatments = [];
        for (var jsonb in responseData) {
          treatments.add(Treatments.fromJson(jsonb));
        }
        print("bu cevap");
        print(treatments);

        return treatments;
      } else {
        print("treantments alınamadı");
        return [];
      }
    } catch (e) {
      print(e);
      print("treatments hata");
      return [];
    }
  }

  final int? id;
  var title;
  final ApplicablePlace? applicablePlace;
  final String? price;
  final Currency? currency;
  final int? canalCount;
  final bool? isActive;

  factory Treatments.fromRawJson(String str) =>
      Treatments.fromJson(json.decode(str));

  factory Treatments.fromJson(Map<String, dynamic> json) => Treatments(
        id: json["id"],
        title: json["title"],
        applicablePlace: applicablePlaceValues.map[json["applicable_place"]]!,
        price: json["price"],
        currency: currencyValues.map[json["currency"]]!,
        canalCount: json["canal_count"],
        isActive: json["is_active"],
      );
}

enum ApplicablePlace { tooth, jaw }

final applicablePlaceValues =
    EnumValues({"tooth": ApplicablePlace.tooth, "jaw": ApplicablePlace.jaw});

enum Currency { TRY }

final currencyValues = EnumValues({"TRY": Currency.TRY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
