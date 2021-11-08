import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looksfreak/Pages/after-approval.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';
import 'package:looksfreak/utils/validators.dart';

import 'landing-page.dart';

class StatusPage extends StatefulWidget {
  final CustomUser user;
  final Server server;
  const StatusPage({Key key, this.user, this.server}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  String status = "Applied";
  // var _val = "Select";

  @override
  void initState() {
    Future.delayed(Duration(seconds: 6))
        .then((value) => {_welcomedialog(context)});
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    await widget.server.fauth.currentUser.reload();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.server.fauth.currentUser.uid.toString())
        .snapshots()
        .listen((event) {
      setState(() {
        status = event.get("status");
        print("status : " + status);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        bottomNavigationBar: status == "Approved"
            ? Container(
                height: height * 0.1,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Home(
                                user: widget.user, server: widget.server)));
                      },
                      child: _button(height, width)),
                ))
            : SizedBox(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                // _showstatusdialog(context);
              },
              child: Icon(
                CupertinoIcons.question_circle,
                color: Colors.white,
                size: height * 0.03,
              ),
            ),
            SizedBox(
              width: width * 0.03,
            )
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        backgroundColor: Color(0xff032d3c),
        body: ListView(
          scrollDirection: Axis.vertical,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    left: width * 0.07,
                    right: width * 0.07,
                    top: height * 0.23),
                child: Text(
                  status == "Approved"
                      ? "Thank You for Registering with LooksFreak\n Let's Begin"
                      : "You Will Recieve A Response Within 48 Hours. Kindly Await Our Response To Upload Your Service on LooksFreak",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mPlusRounded1c(
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
                child: Image.network(
                    status == "Approved"
                        ? "https://i.gifer.com/XwI5.gif"
                        : "https://media.giphy.com/media/S8BY5l1YAfN7VIOhOk/giphy.gif",
                    height: 90.0)),
          ],
        ),
      ),
    );
  }

  Widget _button(height, width) {
    return Container(
      margin: EdgeInsets.only(left: width * 0.18, right: width * 0.18),
      child: Center(
        child: Text(
          "Continue",
          style: GoogleFonts.mPlusRounded1c(
            color: Color(0xff032d3c),
            fontWeight: FontWeight.w600,
            fontSize: height * 0.018,
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

  Future<void> _welcomedialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Column(
          children: [
            SizedBox(
              height: height * 0.25,
            ),
            CupertinoAlertDialog(
              title: Column(
                children: [
                  Center(
                    child: Text(
                      'Welcome',
                      style: GoogleFonts.mPlusRounded1c(
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                        fontSize: height * 0.018,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(
                    color: Color(0xff032d3c),
                    thickness: 1.0,
                  ),
                ],
              ),
              content: Container(
                  margin: EdgeInsets.only(top: height * 0.02),
                  height: height * 0.15,
                  width: width * 0.6,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n Etiam pulvinar porta lacus, at convallis mi tincidunt sit amet.\n Praesent nec ipsum ut velit mattis tempus non vel nisi.\n In elementum augue luctus dictum fringilla.\n Vivamus quis tincidunt eros.\n Praesent lobortis arcu in placerat scelerisque.',
                      style: GoogleFonts.mPlusRounded1c(
                        color: Color(0xff032d3c),
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.016,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Icon(Icons.close, color: Colors.white, size: 20.0),
              ),
            ),
          ],
        );
      },
    );
  }
}
