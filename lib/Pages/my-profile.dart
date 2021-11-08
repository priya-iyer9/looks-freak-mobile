import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:looksfreak/Pages/about-us.dart';
import 'package:looksfreak/Pages/followers.dart';
import 'package:looksfreak/Pages/following.dart';
import 'package:looksfreak/Pages/settings.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';

import 'edit-profile.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  CustomUser user;
  final Server server;
  Profile({Key key, this.user, this.server}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loading = false;
  String ownersname = "", gender = "", fuid = "";
  ScrollController scrollController = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    getUser();
    ownersname = widget.user.ownersname.toString();
    gender = widget.user.gender.toString();
    fuid = widget.user.uid.toString();
    super.initState();
  }

  getUser() async {
    final res = await widget.server.getUserById(widget.user.uid.toString());
    setState(() {
      widget.user = res;
    });
  }

  Future<void> updateUser() async {
    final u = await widget.server.getUserById(widget.user.uid.toString());
    setState(() {
      widget.user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: height * 0.027,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Null>(
                    builder: (context) => EditProfile(),
                  ),
                );
              },
              child: ListTile(
                // ignore: unnecessary_null_comparison
                leading: Image.asset(
                  "assets/me.png",
                  height: height * 0.08,
                ),

                title: Row(
                  children: [
                    Text(
                      ownersname,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: height * 0.027),
                    ),
                    Flexible(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[350],
                      size: height * 0.02,
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    SizedBox(height: height * 0.01),
                    Container(
                      margin: EdgeInsets.only(right: 230),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: gender == "Female"
                            ? Colors.pink[300]
                            : gender == "Male"
                                ? Colors.blue[300]
                                : Colors.orange[300],
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
                              gender == "Female"
                                  ? "F"
                                  : gender == "Male"
                                      ? "M"
                                      : "N",
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
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              fuid,
                              style: TextStyle(
                                  color: Colors.grey[500],
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
                          color: Colors.grey[500],
                          size: height * 0.02,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<Null>(
                        builder: (context) => Following(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.027),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "following",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.022),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width * 0.04),
                Container(
                  height: height * 0.05,
                  width: 0.9,
                  color: Colors.grey[400],
                ),
                SizedBox(width: width * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<Null>(
                        builder: (context) => Followers(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.027),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "Followers",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.022),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (_) => Wallet()),
                // );
              },
              child: _listTile(
                height,
                width,
                CupertinoIcons.exclamationmark_circle,
                "Feedback",
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey[400],
                  size: height * 0.028,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.17),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute<Null>(
                      builder: (context) => AboutUs(),
                    ),
                  );
                },
                child: _listTile(
                  height,
                  width,
                  CupertinoIcons.question_circle,
                  "About",
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[400],
                    size: height * 0.028,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: width * 0.17),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute<Null>(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                child: _listTile(
                  height,
                  width,
                  CupertinoIcons.settings,
                  "Account Settings",
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[400],
                    size: height * 0.028,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: width * 0.17),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
            GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => Levels()),
                  // );
                },
                child: _listTile(
                  height,
                  width,
                  CupertinoIcons.arrow_down_right_arrow_up_left,
                  "Logout",
                  SizedBox(),
                )),
            Padding(
              padding: EdgeInsets.only(left: width * 0.17),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(height, width, icon, String text, trail) {
    return ListTile(
      leading: Icon(icon),
      // Image.asset(
      //   "assets/$icon",
      //   height: height * 0.03,
      // ),
      title: Text(
        "$text",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: height * 0.023),
      ),
      trailing: trail,
    );
  }
}
