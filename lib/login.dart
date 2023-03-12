import 'package:dental_asistanim/carousel.dart';
import 'package:dental_asistanim/login2.dart';
import 'package:dental_asistanim/sizeconfig.dart';
import 'package:faded_widget/faded_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  @override
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _animation = ColorTween(
      begin: Colors.green.withOpacity(0.4),
      end: Colors.blue.withOpacity(0.8),
    ).animate(_animationController);
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_animation.value!, _animation.value!],
              ),
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.safeBlockVertical * 8),
                      Expanded(
                        child: Carousel(
                          texts: [
                            'Dental Asistanım sizlere profesyonel ve yenilikçi çözümler sunmaktadır.',
                            'Dental Asistanım ile sınırsız hasta kaydı ve takibi yapabilirsiniz.',
                            'Hastalar için muayene notları, muayene bilgilerini kaydedebilirsiniz. ',
                          ],
                          children: [
                            Image.asset(
                              './lib/assets/1.jpg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              './lib/assets/2.jpg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              './lib/assets/3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 8),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(PassScreen());
                                },
                                child: Text('Giriş Yap'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 20,
                                  maximumSize: Size(
                                      SizeConfig.safeBlockHorizontal * 80,
                                      SizeConfig.safeBlockVertical * 7),
                                  minimumSize: Size(
                                      SizeConfig.safeBlockHorizontal * 80,
                                      SizeConfig.safeBlockVertical * 7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: Color.fromARGB(255, 26, 184, 87),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Demo talebi için '),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Tıklayınız',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 26, 184, 87),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(height: SizeConfig.safeBlockVertical * 8),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
