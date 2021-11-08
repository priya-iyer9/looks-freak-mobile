import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // final _usernameformKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final _bioformKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  var female = false;
  var male = false;
  String _fuid = "";
  String _name = "";
  String _img = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Icon(
            CupertinoIcons.question_circle,
            color: Colors.yellowAccent.shade700,
            size: height * 0.035,
          ),
          SizedBox(
            width: width * 0.03,
          ),
        ],
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: height * 0.06),
          Center(
            child: Stack(
              children: [
                Image.asset("assets/me.png", height: height * 0.1),
                GestureDetector(
                  onTap: () {
                    // _showPicker(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.073, left: width * 0.12),
                    child: Image.asset("assets/edit-camera.png",
                        height: height * 0.04),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.06),
          Divider(
            thickness: 7.7,
            color: Colors.grey[200],
          ),
          _listtile(
            height,
            width,
            "Username",
            GestureDetector(
              onTap: () {
                _changeUsername(height, width, context);
              },
              child: Text(
                _name.toString(),
                style: TextStyle(
                  fontSize: height * 0.023,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[400],
              size: height * 0.028,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05, bottom: 0.0),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          _listtile(
            height,
            width,
            "Gender",
            Image.asset(
              "assets/femenine.png",
              width: width * 0.06,
            ),
            Text(
              "Female",
              style: TextStyle(
                fontSize: height * 0.023,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05, bottom: 0.0),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          _listtile(
            height,
            width,
            "Date Of Birth",
            Text(
              "2003-05-28",
              style: TextStyle(
                fontSize: height * 0.023,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[400],
              size: height * 0.028,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05, bottom: 0.0),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          _listtile(
            height,
            width,
            "Country",
            Image.asset(
              "assets/india.png",
              width: width * 0.06,
            ),
            Text(
              "India",
              style: TextStyle(
                fontSize: height * 0.023,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05, bottom: 0.0),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          GestureDetector(
            onTap: () {
              _changeBio(height, width, context);
            },
            child: _listtile(
              height,
              width,
              "Bio",
              Text(
                "Write a Short Bio...",
                style: TextStyle(
                  fontSize: height * 0.023,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: height * 0.028,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Divider(
            thickness: 7.7,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.02,
                ),
                Image.asset("assets/profile-tag.png", width: width * 0.07),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  "Tag",
                  style: TextStyle(
                    fontSize: height * 0.023,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Flexible(
                  child: Container(),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey[400],
                  size: height * 0.028,
                ),
                SizedBox(
                  width: width * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listtile(height, width, String title, Widget widget, Widget icon) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            "$title",
            style: TextStyle(
              fontSize: height * 0.023,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          Flexible(
            child: Container(),
          ),
          widget,
          SizedBox(
            width: width * 0.01,
          ),
          icon,
          SizedBox(
            width: width * 0.02,
          ),
        ],
      ),
    );
  }

  _changeUsername(height, width, context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            insetPadding: EdgeInsets.only(
                left: width / 55,
                right: width / 55,
                top: height * 0.2,
                bottom: height * 0.4),
            titlePadding: EdgeInsets.all(0),
            title: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Username",
                style: TextStyle(
                    color: Colors.grey[800],
                    // fontSize: height * 0.02,
                    fontWeight: FontWeight.w800),
              ),
            )),
            content: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.02, 0.0, width * 0.02, 0.0),
                  child: TextFormField(
                    maxLines: 3,
                    maxLength: 20,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "required";
                      } else {
                        return "required";
                      }
                    },
                    controller: _usernameController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "Enter Username",
                      hintStyle: TextStyle(
                          fontSize: height * 0.016,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: _buttons(
                            height, width, "Cancel", Colors.grey.shade200)),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    GestureDetector(
                        onTap: () {
                          // FirebaseFirestore.instance
                          //     .collection('USERS')
                          //     .doc("${_fuid.toString()}")
                          //     .update({
                          //   "name": _usernameController.text,
                          // });

                          // Navigator.of(context).pop();
                          // setState(() {
                          //   _name = _usernameController.text;
                          // });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Username updated')));
                        },
                        child: _buttons(height, width, "Submit", Colors.amber)),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _changeBio(height, width, context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            insetPadding: EdgeInsets.only(
                left: width / 55,
                right: width / 55,
                top: height * 0.2,
                bottom: height * 0.4),
            titlePadding: EdgeInsets.all(0),
            title: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bio",
                style: TextStyle(
                    color: Colors.grey[800],
                    // fontSize: height * 0.02,
                    fontWeight: FontWeight.w800),
              ),
            )),
            content: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.02, 0.0, width * 0.02, 0.0),
                  child: TextFormField(
                    maxLines: 3,
                    maxLength: 20,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "required";
                      } else {
                        return "required";
                      }
                    },
                    controller: _bioController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "Enter Bio",
                      hintStyle: TextStyle(
                          fontSize: height * 0.016,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: _buttons(
                            height, width, "Cancel", Colors.grey.shade200)),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    GestureDetector(
                        onTap: () {
                          // FirebaseFirestore.instance
                          //     .collection('USERS')
                          //     .doc("${_fuid.toString()}")
                          //     .set({
                          //   "bio": _bioController.text,
                          // }, SetOptions(merge: true));

                          // Navigator.of(context).pop();
                          // setState(() {
                          //   _bio = _bioController.text;
                          // });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Bio updated')));
                        },
                        child: _buttons(height, width, "Submit", Colors.amber)),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buttons(height, width, text, Color colour) {
    return Container(
      height: height * 0.04,
      width: width * 0.3,
      decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.all(Radius.circular(100.0))),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: height * 0.0167,
          fontWeight: FontWeight.w500,
        ),
      )),
    );
  }
}
