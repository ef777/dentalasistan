// Bu card ekranda gözükecek seçimler için yapılmıştır

import 'package:flutter/material.dart';

import 'SelectionModel.dart';
import 'const.dart';
import 'custon_button.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    Key? key,
    required this.size,
    required this.selectionCardModel,
    required this.onPressed,
  }) : super(key: key);
  final SelectionCardModel selectionCardModel;
  final Size size;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(dfBorderRadius / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 3),
              blurRadius: 8.0,
              spreadRadius: 8.0,
            ),
          ],
        ),
        child: _cardDesign(context),
      ),
    );
  }

  Row _cardDesign(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(dfBorderRadius / 2),
          child: Image.asset(
            selectionCardModel.image,
            width: 152,
            height: 112,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: size.width * 0.04,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectionCardModel.title,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomButton(onPressed: onPressed)
            ],
          ),
        )
      ],
    );
  }
}
