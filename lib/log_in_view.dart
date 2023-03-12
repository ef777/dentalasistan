import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:dental_asistanim/home.dart';
import 'package:dental_asistanim/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config.dart';
import 'custon_button.dart';
import 'home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailText = TextEditingController();
    TextEditingController passwordText = TextEditingController();
    var size = MediaQuery.of(context).size;
    loginol(mail, sifre) async {
      try {
        var url = Uri.parse('https://demo.dentalasistanim.com/api/auth/login');
        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "email": mail,
            "password": sifre,
          }),
        );
        String responseString = response.body;
        Map<String, dynamic> responseData = json.decode(responseString);
        String token = responseData['token'];
        print(token);
        Config.token = token;

        if (response.statusCode == 200) {
          Get.snackbar('Başarılı', 'Giriş Başarılı');
          Get.to(() => HomeView());
        } else {
          Get.snackbar('Hata', 'Kullanıcı adı veya şifre hatalı');
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 244, 244, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Tekrardan Hoşgeldiniz !",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "Dental Asistanım uygulamasına hoşgeldiniz ",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(
              height: size.height * 0.20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: emailText,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                      size: 22,
                    )),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: passwordText,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Parola",
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                      size: 22,
                    )),
              ),
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Parolayı mı unuttunuz ?",
                  style: Theme.of(context).textTheme.bodyText2,
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomButton(
              onPressed: (() {
                emailText.text = "ile@dentalasistan.com";
                passwordText.text = "123123";
                loginol(emailText.text, passwordText.text);
              }),
              width: 325,
              height: 48,
              radius: 16,
              title: "Giriş Yap",
            )
          ],
        ),
      ),
    );
  }
}
