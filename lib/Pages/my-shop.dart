import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';

import 'my-profile.dart';

class MyShop extends StatefulWidget {
  final CustomUser user;
  final Server server;
  const MyShop({Key key, this.user, this.server}) : super(key: key);

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "My Shop",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        Profile(user: widget.user, server: widget.server)));
              },
              icon: Icon(CupertinoIcons.person_alt_circle_fill,
                  color: Colors.blue),
              iconSize: 50.0,
            ),
            SizedBox(width: 20)
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    // ignore: unnecessary_null_comparison
                    leading: Image.asset(
                      "assets/me.png",
                      height: height * 0.08,
                    ),

                    title: Text(
                      "Manny's",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: height * 0.027),
                    ),

                    subtitle: Column(
                      children: [
                        SizedBox(height: height * 0.01),
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[400],
                              ),
                              margin: EdgeInsets.only(
                                left: width * 0.01,
                                right: width * 0.01,
                              ),
                              height: height * 0.027,
                              width: width * 0.1,
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Icon(
                                      Icons.star_half_sharp,
                                      color: Colors.grey[50],
                                      size: height * 0.02,
                                    ),
                                    Flexible(
                                      child: Container(),
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.grey[50],
                                          fontWeight: FontWeight.w700,
                                          fontSize: height * 0.0179),
                                    ),
                                    SizedBox(
                                      width: width * 0.015,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[400],
                              ),
                              margin: EdgeInsets.only(
                                left: width * 0.01,
                                right: width * 0.01,
                              ),
                              height: height * 0.027,
                              width: width * 0.1,
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Icon(
                                      Icons.thumb_up_off_alt,
                                      color: Colors.grey[50],
                                      size: height * 0.02,
                                    ),
                                    Flexible(
                                      child: Container(),
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.grey[50],
                                          fontWeight: FontWeight.w700,
                                          fontSize: height * 0.0179),
                                    ),
                                    SizedBox(
                                      width: width * 0.015,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.pink[300],
                              ),
                              margin: EdgeInsets.only(
                                left: width * 0.01,
                                right: width * 0.01,
                              ),
                              height: height * 0.027,
                              width: width * 0.1,
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Icon(
                                      Icons.female_outlined,
                                      color: Colors.grey[50],
                                      size: height * 0.02,
                                    ),
                                    Flexible(
                                      child: Container(),
                                    ),
                                    Text(
                                      "F",
                                      style: TextStyle(
                                          color: Colors.grey[50],
                                          fontWeight: FontWeight.w700,
                                          fontSize: height * 0.0179),
                                    ),
                                    SizedBox(
                                      width: width * 0.015,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.01),
                                child: Text(
                                  "ID: 123456789",
                                  style: TextStyle(
                                      color: Colors.grey[50],
                                      fontWeight: FontWeight.w700,
                                      fontSize: height * 0.023),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Icon(
                              Icons.copy_rounded,
                              color: Colors.grey[50],
                              size: height * 0.02,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "It serves diverse customer base Pan India through state-of-the-art service facilities in Mumbai, Thane, Navi Mumbai, Delhi, Hyderabad, Bangalore, Ahmedabad and is soon to be expanded to rest of India. It offers wide range of Beauty & Wellness Services like Cut & Style, Skincare, Treatments, Hand & Foot SPA, Reflexology, Bridal & Fashion Make-up, Hair Updos, Tattoo & Nail-art / Extensions etc. The Salon Format of “Kapils Salon & Academy” are Family Salon, Premium Salon, Luxury Salon, Studio Salon as well as fashion kiosk.",
                      style: TextStyle(
                          color: Colors.grey[50],
                          fontWeight: FontWeight.w700,
                          fontSize: height * 0.015),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
              height: height * 0.28,
              width: width * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xff00bfff),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),
            Divider(
              height: height * 0.04,
              color: Colors.grey[350],
              thickness: 1.0,
            ),
            Container(
                margin:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                height: height * 0.8,
                width: width * 0.8,
                decoration: BoxDecoration(color: Colors.grey[100])),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
