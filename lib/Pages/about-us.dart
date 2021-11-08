import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            CupertinoIcons.refresh_thick,
            color: Colors.black,
          ),
          SizedBox(
            width: width * 0.03,
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "About Us",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          // Center(
          //   child: Image.asset(
          //     "assets/cat2.png",
          //     height: height * 0.17,
          //   ),
          // ),
          // SizedBox(
          //   height: height * 0.015,
          // ),
          Center(
            child: Text(
              "LooksFreak",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: height * 0.024,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Center(
            child: Text(
              "version 1.0.0",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: height * 0.35,
          ),
          Center(
            child: Text(
              "LooksFreak",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: height * 0.024,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: Text(
              "Support@LooksFreak.in",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
