import 'package:dental_asistanim/const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.title,
  }) : super(key: key);
  final void Function() onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 140,
      height: height ?? 25,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: solidColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(radius ?? dfBorderRadius / 2))),
          onPressed: onPressed,
          child: Text(title ?? "Devam Et")),
    );
  }
}
