import 'package:agenda_luthfi/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double defaultMargin = 24.0;
double defaultRadius = 17.0;

Color kPrimaryColor = Color(0xff5C40CC);
Color kBlackColor = Color(0xff1F1449);
Color kWhiteColor = Color(0xffFFFFFF);
Color kGreyColor = Color(0xff9698A9);
Color kGreyTextColor = Color(0xff8B8B8B);
Color kGreenColor = Color(0xff0EC3AE);
Color kRedColor = Color(0xffEB70A5);
Color kAgendaContainerColor = Color(0xffFCEBE4);
Color kBackgroundColor = Color(0xffFAFAFA);
Color kInactiveColor = Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;
Color kAvailabelColor = Color(0xffE0D9FF);
Color kUnAvailabelColor = Color(0xffEBECF1);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

convertDate(String convert, String format) {
  DateTime dt = DateTime.parse(convert);
  return DateFormat(format).format(dt);
}

String? userGlobal;
