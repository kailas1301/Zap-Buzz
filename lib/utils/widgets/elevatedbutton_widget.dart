import 'package:flutter/material.dart';
import 'package:zapbuzz/presentation/utils/const/const.dart';
import 'package:zapbuzz/utils/widgets/textwidgets.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.width,
      this.textsize});
  final void Function() onPressed;
  final String buttonText;
  final double width;
  final double? textsize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryDarkColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SubHeadingTextWidget(
            textsize: textsize ?? 14,
            title: buttonText,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
