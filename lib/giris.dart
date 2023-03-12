import 'package:dental_asistanim/sizeconfig.dart';
import 'package:faded_widget/faded_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'log_in_view.dart';

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
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(10),
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
                          )),
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
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal * 80,
                              height: SizeConfig.safeBlockVertical * 7,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(LoginView());
                                },
                                child: Text(
                                  'Giriş Yap',
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: Colors.blue,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  textStyle: TextStyle(fontSize: 20),
                                ),
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
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

class Carousel extends StatefulWidget {
  final List<Widget> children;
  final List<String> texts;

  final double height;
  final double width;
  final double borderRadius;
  final double padding;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final int initialPage;
  final bool autoPlay;
  final int autoPlayInterval;
  final bool enableInfiniteScroll;
  final bool enlargeCenterPage;
  final double onPageChanged;
  final Curve curve;
  final Duration duration;
  final Function(int)? onPageChangedCallback;
  final Function(int)? onScrollEndCallback;

  Carousel({
    Key? key,
    required this.children,
    required this.texts,
    this.height = 400.0,
    this.width = 1200.0,
    this.borderRadius = 5.0,
    this.padding = 5.0,
    this.borderColor = Colors.transparent,
    this.borderWidth = 2.0,
    this.backgroundColor = Colors.white,
    this.initialPage = 0,
    this.autoPlay = true,
    this.autoPlayInterval = 3000,
    this.enableInfiniteScroll = true,
    this.enlargeCenterPage = false,
    this.onPageChanged = 1,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 300),
    this.onPageChangedCallback,
    this.onScrollEndCallback,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(
      initialPage: widget.initialPage,
      viewportFraction: widget.onPageChanged,
    );
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _startAutoPlay() {
    Future.delayed(Duration(milliseconds: widget.autoPlayInterval), () {
      if (!_isScrolling) {
        _pageController.nextPage(
          duration: widget.duration,
          curve: widget.curve,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 2,
      width: widget.width * 0.80,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: widget.borderColor,
          width: widget.borderWidth * 15,
        ),
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _pageController,
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              // FadedWidget
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FadedWidget(
                    height: SizeConfig.screenHeight * 0.50,
                    width: SizeConfig.screenWidth * 0.90,
                    direction: GradientDirection.ttb,
                    fade: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                    ],
                    child: widget.children[index],
                  ));
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (widget.onPageChangedCallback != null) {
                widget.onPageChangedCallback!(_currentPage);
              }
            },
            scrollDirection: Axis.horizontal,
            physics: widget.enableInfiniteScroll
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
          ),

          // Text label
          Positioned(
            bottom: SizeConfig.screenHeight * 0.0120,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
            child: Center(
              child: Text(
                widget.texts[_currentPage],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          // Page indicators
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children.map((url) {
                int index = widget.children.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index ? Colors.blueAccent : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
