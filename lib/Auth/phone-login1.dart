import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looksfreak/Pages/landing-page.dart';
import 'package:looksfreak/Pages/profile-page.dart';
import 'package:looksfreak/services/localDB.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';
import 'package:looksfreak/utils/validators.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneLogin extends StatefulWidget {
  final Server server;
  PhoneLogin({Key key, this.server}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _write = false;
  var _countrycodeValue;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String verificationId = "";
  bool showLoadng = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var registration;

  String text = "+91-9873092109";

  List<String> _countrycode = <String>[
    '+91',
    '+61',
    '+44',
    '+1',
  ];

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoadng = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoadng = false;
      });
      String registrationtype = "", status = "";
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.server.fauth.currentUser.uid.toString())
          .snapshots()
          .listen((event) {
        setState(() {
          status = event.get("status");
          print("status : " + status);
          registrationtype = event.get("registrationtype");
          print("registrationtype : " + registrationtype);
        });
      });

      final phoneExists = await widget.server
          .checkUserByPhone(authCredential.user.phoneNumber.toString());
      if (phoneExists.found &&
          !phoneExists.user.isUptodate &&
          status == "Applied") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              const Text('phone exists /user not uptodate/ status is applied'),
          duration: const Duration(seconds: 1),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      server: widget.server,
                      user: phoneExists.user,
                    )));
      } else if (phoneExists.found &&
          phoneExists.user.isUptodate &&
          status == "Approved") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              const Text('phone exists /user uptodate/ status is approved'),
          duration: const Duration(seconds: 1),
        ));
        await UserDatabase.setUser(phoneExists.user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Home(user: phoneExists.user, server: widget.server)));
      } else if (!phoneExists.found) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('phone does not exist/ registering'),
          duration: const Duration(seconds: 1),
        ));

        final CustomUser user = CustomUser(
            ownersname: authCredential.user.displayName.toString() ?? "",
            uid: authCredential.user.uid.toString(),
            email: authCredential.user.email ?? "",
            phonenumber: authCredential.user.phoneNumber.toString());
        final r = await widget.server.createUserRecord(user);

        user.uid = r.insertedId;
        await UserDatabase.setUser(user);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProfilePage(user: user, server: widget.server)));
      } else if (phoneExists.found && registrationtype != "PHONE") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('You have used another login type'),
          duration: const Duration(seconds: 1),
        ));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error sgining in')));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoadng = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xff032d3c),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            SizedBox(height: height * 0.3),
            showLoadng == true
                ? Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // image: DecorationImage(
                      //   image: AssetImage("assets/doctor-phone-bg.png"),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.pinkAccent,
                      ),
                    ),
                  )
                : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? enterPhone(height, width, context)
                    : otpFields(height, width, context),
          ],
        ),
      ),
    );
  }

  Widget enterPhone(height, width, context) {
    return Container(
      height: height * 0.7,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(21.0), topLeft: Radius.circular(21.0)),
        color: Color(0xff032d3c),
        gradient: LinearGradient(
            colors: [Color(0xFF94fc13), Color(0xff4be3ac)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: height * 0.03,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          Text(
            "Login With Mobile Number",
            style: GoogleFonts.mPlusRounded1c(
                color: Colors.white,
                fontSize: height * 0.03,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.1,
              ),
              Container(
                width: width * 0.25,
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.white,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: Colors.grey[100],
                      items: _countrycode
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent),
                                ),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (selectedtype) {
                        setState(() {
                          _countrycodeValue = selectedtype;
                        });
                      },
                      value: _countrycodeValue,
                      hint: Container(
                        width: width * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/india-flag.png",
                                height: height * 0.03,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              "+91",
                              style: GoogleFonts.mPlusRounded1c(
                                color: Color(0xff032d3c),
                                fontWeight: FontWeight.w800,
                                fontSize: height * 0.018,
                              ),
                            ),
                          ],
                        ),
                      ),
                      elevation: 0,
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.0, right: width * 0.1),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.transparent,
                      child: TextFormField(
                        style: GoogleFonts.mPlusRounded1c(
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        validator: (value) {
                          isValidPhoneNumber(value);
                          return 'please enter a valid phone number';
                        },
                        onChanged: (val) {
                          setState(() {
                            _write = true;
                          });
                        },
                        obscureText: false,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Mobile Number',
                          hintStyle: GoogleFonts.mPlusRounded1c(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: false,
                          contentPadding: EdgeInsets.all(15),
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.1,
          ),
          GestureDetector(
              onTap: () async {
                setState(() {
                  showLoadng = true;
                  text = _phoneController.text;
                });
                await _auth.verifyPhoneNumber(
                  phoneNumber: "+91" + _phoneController.text,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoadng = false;
                    });
                  },
                  verificationFailed: (verificationFailed) async {
                    showLoadng = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(verificationFailed.message.toString())));
                  },
                  codeSent: (verificationId, resendingToken) async {
                    showLoadng = false;
                    setState(() {
                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {},
                );
              },
              child: _getotptile(height, width, context)),
        ],
      ),
    );
  }

  Widget otpFields(height, width, context) {
    return Container(
      height: height * 0.7,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(21.0), topLeft: Radius.circular(21.0)),
        color: Color(0xff032d3c),
        gradient: LinearGradient(
            colors: [Color(0xFF94fc13), Color(0xff4be3ac)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: height * 0.03,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          Text(
            "Enter Verification Code",
            style: GoogleFonts.mPlusRounded1c(
                color: Colors.white,
                fontSize: height * 0.037,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          RichText(
            text: TextSpan(
              text:
                  'The Verification Code Has Been Sent To Your\n Mobile Number ',
              style: GoogleFonts.mPlusRounded1c(
                  color: Colors.white,
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                  text: ' +91-$text',
                  style: GoogleFonts.mPlusRounded1c(
                      color: Colors.white,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.2, right: width * 0.2),
            child: OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: width * 0.08,
              style: TextStyle(fontSize: height * 0.024, color: Colors.white),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              otpFieldStyle: OtpFieldStyle(enabledBorderColor: Colors.white),
              onCompleted: (pin) {
                print("Completed: " + pin);
                setState(() {
                  _otpController.text = pin;
                });
              },
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          RichText(
            text: TextSpan(
              text: 'Didn\'t Recieve The OTP? ',
              style: GoogleFonts.mPlusRounded1c(
                  color: Colors.white,
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                  text: ' Resend OTP',
                  style: GoogleFonts.mPlusRounded1c(
                      color: Colors.indigo,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.07,
          ),
          GestureDetector(
              onTap: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: _otpController.text);

                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: _verifyotptile(height, width, context)),
        ],
      ),
    );
  }

  Widget _verifyotptile(height, width, context) {
    return Center(
      child: Container(
        // margin: EdgeInsets.only(
        //     left: width * 0.2, right: width * 0.2, top: height * 0.01),
        height: height * 0.06,
        width: width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: width * 0.003),
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(colors: [
            _write == true ? Colors.white : Color(0xFF94c13),
            _write == true ? Colors.white : Color(0xff4be3ac),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            "Verify & Proceed",
            style: TextStyle(
                color: _write == true ? Color(0xff032d3c) : Colors.white,
                fontSize: height * 0.018,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _getotptile(height, width, context) {
    return Center(
      child: Container(
        // margin: EdgeInsets.only(
        //     left: width * 0.2, right: width * 0.2, top: height * 0.01),
        height: height * 0.06,
        width: width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: width * 0.003),
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(colors: [
            _write == true ? Colors.white : Color(0xFF94c13),
            _write == true ? Colors.white : Color(0xff4be3ac),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            "Get OTP",
            style: TextStyle(
                color: _write == true ? Color(0xff032d3c) : Colors.white,
                fontSize: height * 0.018,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
