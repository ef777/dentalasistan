/* carousel widget without packet for flutter 2.2.3
 */
import 'package:dental_asistanim/sizeconfig.dart';
import 'package:faded_widget/faded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
    this.height = 200.0,
    this.width = 1200.0,
    this.borderRadius = 5.0,
    this.padding = 5.0,
    this.borderColor = Colors.grey,
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
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              return FadedWidget(
                  height: SizeConfig.screenHeight * 0.50,
                  width: SizeConfig.screenWidth * 0.90,
                  direction: GradientDirection.ttb,
                  fade: [
                    Colors.transparent,
                    Colors.grey,
                    Colors.white,
                  ],
                  child: widget.children[index]);
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
          Positioned(
            bottom: SizeConfig.screenHeight * 0.080,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
            child: Center(
                child: Text(
              widget.texts[_currentPage],
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
          ),
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
