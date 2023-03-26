import 'package:dental_asistanim/const.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:dental_asistanim/etc/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';
import '../etc/custon_button.dart';
import '../home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  bool isLoading = false;

  Widget build(BuildContext context) {
    TextEditingController emailText = TextEditingController();
    TextEditingController passwordText = TextEditingController();
    var size = MediaQuery.of(context).size;
    emailText.text = "ile@dentalasistan.com";
    passwordText.text = "123123";
    girisvesubeid() async {
      try {
        print("bu auth");
        print(Config.token);
        var url = Uri.parse('https://demo.dentalasistanim.com/api/me');
        var response = await http.get(
          url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Config.token}'
          },
        );
        String responseString = response.body;
        Map<String, dynamic> responseData = json.decode(responseString);
        print("bu iki");
        print(responseData);

        Config.subeid = responseData['tenant_id'].toString();
        Config.id = responseData['id'].toString();
        Config.name = responseData['name'].toString();
        Config.email = responseData['email'].toString();
        Config.phone = responseData['phone'].toString();
        Config.status = responseData['status'].toString();
        Config.role = responseData['role_id'].toString();

        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }

    loginol(mail, sifre) async {
      setState(() {
        isLoading = true;
      });
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
        await girisvesubeid();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 244, 244, 1),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 32, 97, 172),
                Color.fromARGB(255, 43, 72, 166),
                Color.fromARGB(255, 1, 8, 53)
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Giriş Yap",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Dental Asistanım Uygulamasına Yeniden Hoşgeldin",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42),
                              topRight: Radius.circular(42))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(75, 27, 43, 225),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 238, 238, 238)))),
                                      child: TextField(
                                        controller: emailText,
                                        decoration: const InputDecoration(
                                            hintText: "E-mailinizi Giriniz",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 238, 238, 238)))),
                                      child: TextField(
                                        controller: passwordText,
                                        decoration: const InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Parolayı mı unuttunuz ?",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              //         CustomButton(
                              CustomButton(
                                color: sfColor,
                                onPressed: (() async {
                                  var son = await loginol(
                                      emailText.text, passwordText.text);

                                  if (son == true) {
                                    Get.snackbar('Başarılı', 'Giriş Başarılı');
                                    Get.to(() => HomeView(
                                          name: Config.name,
                                        ));
                                  } else {
                                    Get.snackbar('Başarısız', 'Şifre hatalı');
                                  }
                                }),
                                width: double.infinity,
                                height: 48,
                                radius: 16,
                                title: "Giriş Yap",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

      // SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Center(
      //           child: Text(
      //             "Tekrardan Hoşgeldiniz !",
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .headlineSmall
      //                 ?.copyWith(fontWeight: FontWeight.w700),
      //           ),
      //         ),
      //         SizedBox(
      //           height: size.height * 0.01,
      //         ),
      //         Text(
      //           "Dental Asistanım uygulamasına hoşgeldiniz ",
      //           style: Theme.of(context)
      //               .textTheme
      //               .caption
      //               ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      //         ),
      //         SizedBox(
      //           height: size.height * 0.20,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 16),
      //           child: TextField(
      //             controller: emailText,
      //             keyboardType: TextInputType.emailAddress,
      //             decoration: InputDecoration(
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(16.0),
      //                   borderSide: BorderSide.none,
      //                 ),
      //                 filled: true,
      //                 fillColor: Colors.white,
      //                 hintText: "Email",
      //                 prefixIcon: const Icon(
      //                   Icons.email_outlined,
      //                   color: Colors.grey,
      //                   size: 22,
      //                 )),
      //           ),
      //         ),
      //         SizedBox(
      //           height: size.height * 0.02,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 16),
      //           child: TextField(
      //             controller: passwordText,
      //             decoration: InputDecoration(
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(16.0),
      //                   borderSide: BorderSide.none,
      //                 ),
      //                 filled: true,
      //                 fillColor: Colors.white,
      //                 hintText: "Parola",
      //                 prefixIcon: const Icon(
      //                   Icons.password,
      //                   color: Colors.grey,
      //                   size: 22,
      //                 )),
      //           ),
      //         ),
      //         SizedBox(
      //           height: size.height * 0.09,
      //         ),
      //         TextButton(
      //             onPressed: () {},
      //             child: Text(
      //               "Parolayı mı unuttunuz ?",
      //               style: Theme.of(context).textTheme.bodyText2,
      //             )),
      //         SizedBox(
      //           height: size.height * 0.02,
      //         ),
      //         CustomButton(
      //           onPressed: (() async {
      //             var son =
      //                 await loginol(emailText.text, passwordText.text);

      //             if (son == true) {
      //               Get.snackbar('Başarılı', 'Giriş Başarılı');
      //               Get.to(() => HomeView(
      //                     name: Config.name,
      //                   ));
      //             } else {
      //               Get.snackbar('Başarısız', 'Şifre hatalı');
      //             }
      //           }),
      //           width: 325,
      //           height: 48,
      //           radius: 16,
      //           title: "Giriş Yap",
      //         )
      //       ],
      //     ),
      //   ),
    );
  }
}
