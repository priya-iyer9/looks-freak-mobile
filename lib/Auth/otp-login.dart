import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpLogin extends StatefulWidget {
  const OtpLogin({Key key}) : super(key: key);

  @override
  _OtpLoginState createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _write = false;
  var _countrycodeValue;

  String verificationId = "";
  bool showLoadng = false;
  var registration;

  String text = "+91-9873092109";

  List<String> _countrycode = <String>[
    '+91',
    '+61',
    '+44',
    '+1',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff032d3c),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.3,
          ),
          otpFields(height, width, context),
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
                  text: ' +91-2345678986',
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
              onTap: () async {},
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
        width: width * 0.6,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: width * 0.003),
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              colors: [Color(0xFF94fc13), Color(0xff4be3ac)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            "Verify And Procced",
            style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.02,
                fontWeight: FontWeight.w700),
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
            _write == true ? Color(0xFF94c13) : Colors.white,
            _write == true ? Color(0xff4be3ac) : Colors.white,
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            "Get OTP",
            style: TextStyle(
                color: _write == true ? Colors.white : Color(0xff032d3c),
                fontSize: height * 0.02,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
