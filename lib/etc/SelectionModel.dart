// ignore_for_file: public_member_api_docs, sort_constructors_first
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
