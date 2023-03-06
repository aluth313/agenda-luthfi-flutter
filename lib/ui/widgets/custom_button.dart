import 'package:agenda_luthfi/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final Color? colorButton;

  const CustomButtom(
      {Key? key,
      required this.title,
      this.width = double.infinity,
      this.colorButton,
      required this.onPressed,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        style: TextButton.styleFrom(
            backgroundColor: colorButton ?? kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius))),
      ),
    );
  }
}
