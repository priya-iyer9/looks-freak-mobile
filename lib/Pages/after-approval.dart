import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looksfreak/Pages/landing-page.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff032d3c),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              'Welcome',
              style: GoogleFonts.mPlusRounded1c(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: height * 0.05,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              'To',
              style: GoogleFonts.mPlusRounded1c(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: height * 0.05,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              'LooksFreak',
              style: GoogleFonts.mPlusRounded1c(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: height * 0.05,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.4,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute<Null>(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Continue',
                  style: GoogleFonts.mPlusRounded1c(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: height * 0.04,
                  ),
                ),
                // SizedBox(
                //   width: width * 0.1,
                // ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
