import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String title;

  PrimaryButton({this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: width * 0.18, right: width * 0.18),
      child: Center(
        child: Text(
          title.toString(),
          style: GoogleFonts.mPlusRounded1c(
            color: Color(0xff032d3c),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
      height: height * 0.06,
      width: width * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String title;

  SecondaryButton({this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
        child: Text(
          title.toString(),
          style: GoogleFonts.mPlusRounded1c(
            color: Color(0xff032d3c),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
      height: height * 0.05,
      width: width * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
    );
  }
}
