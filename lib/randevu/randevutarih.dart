import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _selectedDate = DateTime.now();
  String formattedDate = "Tarih Seçiniz";
  TimeOfDay? firstclock = TimeOfDay.now();
  var donen = [];
  var deger1 = " Seçiniz";
  var deger2 = "Seçiniz";
  TimeOfDay? endclock = TimeOfDay.now();

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Randevu Onayla'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Gün: ${formattedDate}',
                ),
                SizedBox(height: 10.0),
                Text(
                    'Zaman: ${firstclock!.hour}:${firstclock!.minute} - ${endclock!.hour}:${endclock!.minute}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {},
            ),
            TextButton(
                child: Text('Onayla'),
                onPressed: () {
                  // Geri döndürülecek değeri belirle
                  if (firstclock != null) {
                    Navigator.of(context).pop();

                    Get.back(
                        result: donen = [
                      firstclock,
                      endclock,
                      _selectedDate,
                      formattedDate
                    ]);
                  } else {
                    Get.snackbar("Hata", "Lütfen tüm alanları doldurunuz");
                  }
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Randevu Günü/Saati'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Gün Seç',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month - 1, _selectedDate.day);
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  label: Text(''),
                ),
                TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 16,
                    );

                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                        formattedDate = DateFormat('dd MMMM yyyy', 'tr_TR')
                            .format(_selectedDate);
                        print(formattedDate);
                        print("bu deger");
                      });
                    }
                  },
                  child: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month + 1, _selectedDate.day);
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  label: Text(''),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Saat Seç',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 120.0,
                      child: Column(children: [
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () async {
                              firstclock = await showRoundedTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              setState(() {
                                deger1 =
                                    "${firstclock!.hour}  ${firstclock!.minute} ";
                              });
                            },
                            icon: Icon(Icons.lock_clock, size: 100)),
                        TextButton(
                            child: Text(deger1),
                            onPressed: () async {
                              firstclock = await showRoundedTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              setState(() {
                                deger1 =
                                    "${firstclock!.hour}  ${firstclock!.minute} ";
                              });
                            })
                      ])),
                  Container(
                      height: 120.0,
                      child: Column(children: [
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () async {
                              endclock = await showRoundedTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              setState(() {
                                deger2 =
                                    "${endclock!.hour}  ${endclock!.minute} ";
                              });
                            },
                            icon: Icon(Icons.lock_clock, size: 100)),
                        TextButton(
                            child: Text(deger2),
                            onPressed: () async {
                              endclock = await showRoundedTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              setState(() {
                                deger2 =
                                    "${endclock!.hour}  ${endclock!.minute} ";
                              });
                            })
                      ])),
                ]),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                child: Text('Randevu EKle'),
                onPressed: () {
                  _showConfirmationDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
