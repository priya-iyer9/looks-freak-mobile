import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looksfreak/Pages/status-page.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';
import 'package:looksfreak/utils/validators.dart';
import 'package:looksfreak/widgets/buttons.dart';
import 'package:looksfreak/widgets/inputFields.dart';

class ProfilePage extends StatefulWidget {
  final CustomUser user;
  final Server server;
  const ProfilePage({Key key, this.user, this.server}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _businessnameController = TextEditingController();
  final searchController = TextEditingController(text: "Select Type");
  final businessproofController = TextEditingController(text: "Select Proof");
  final identityproofController = TextEditingController(text: "Select Proof");
  final genderController = TextEditingController(text: "Select Gender");
  final _ownersnameController = TextEditingController();
  final _dobController = TextEditingController();
  final _shopnumberController = TextEditingController();
  final _streetnameController = TextEditingController();
  final _areaController = TextEditingController();
  final _townController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _mobileController = TextEditingController();
  final _altmobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _licensenoController = TextEditingController();
  bool loading;
  final _businessnameformKey = GlobalKey<FormState>();
  TimeOfDay opentime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay closetime = TimeOfDay(hour: 7, minute: 15);

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => {_welcomedialog(context)});
    _emailController.text = widget.user.email.toString();
    _ownersnameController.text = widget.user.ownersname.toString();
    loading = false;
    // widget.server.getUserRecord(widget.user);
    super.initState();
  }

  void _selectopenTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        opentime = newTime;
      });
    }
  }

  void _selectcloseTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closetime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _areyousuredialog(context);
        },
        child: Container(
            height: height * 0.1,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: PrimaryButton(
                title: "Submit",
              ),
            )),
      ),
      appBar: AppBar(
        // leading: GestureDetector(
        //     onTap: () {
        //       _areyousuredialog(context);
        //     },
        //     child: Text("pop up")),
        bottom: PreferredSize(
          preferredSize: Size(width, height * 0.02),
          child: Divider(
            color: Colors.white,
            thickness: 1.0,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Apply To Create You New LooksFreak Account",
          style: GoogleFonts.mPlusRounded1c(
            letterSpacing: 1.0,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xff032d3c),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.12),
            child: Text(
              "Business Details",
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 1.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            maxlength: 50,
            controller: _businessnameController,
            hint: "Business Name",
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
            child: CustomDropDown(
              hint: "Select Type",
              text: searchController.text.toString(),
              collection: "business_type",
              error: false,
              onChanged: (q) {
                setState(() {
                  searchController.text = q;
                });
              },
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    _selectopenTime();
                  },
                  child: SecondaryButton(
                    title:
                        "${opentime.hour.toString()} ${opentime.minute.toString()} AM",
                  )),
              GestureDetector(
                onTap: () {
                  _selectcloseTime();
                },
                child: SecondaryButton(
                  title:
                      "${closetime.hour.toString()} ${closetime.minute.toString()}  PM",
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.06,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.12),
            child: Text(
              "Personal Details",
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 1.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _ownersnameController,
            hint: "Owners Name",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
            child: CustomDropDown(
              hint: "Select Gender",
              text: genderController.text.toString(),
              error: false,
              onChanged: (q) {
                setState(() {
                  genderController.text = q;
                });
              },
              collection: 'Genders',
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _dobController,
            hint: "Date of Birth",
            keyboardType: TextInputType.datetime,
          ),
          SizedBox(
            height: height * 0.06,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.12),
            child: Text(
              "Contact Details",
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 1.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _shopnumberController,
            hint: "Shop / Plot No.",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _streetnameController,
            hint: "Street No. / Name",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _areaController,
            hint: "Area",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _townController,
            hint: "Town",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _cityController,
            hint: "City",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _stateController,
            hint: "State",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _countryController,
            hint: "Canada",
            readOnly: true,
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _mobileController,
            hint: "Mobile No.",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            controller: _altmobileController,
            hint: "Alt. Mobile No.",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            // initialValue: widget.user.email.toString() ?? "email",
            controller: _emailController,
            hint: "Email Id",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.06,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.12),
            child: Text(
              "Business Verification",
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 1.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InputField(
            maxlength: 12,
            controller: _licensenoController,
            hint: "License No.",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
            child: CustomDropDown(
              hint: "Select Proof",
              text: businessproofController.text.toString(),
              error: false,
              onChanged: (q) {
                setState(() {
                  businessproofController.text = q;
                });
              },
              collection: 'business_proof',
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
            child: CustomDropDown(
              hint: "Select Proof",
              text: identityproofController.text.toString(),
              error: false,
              onChanged: (q) {
                setState(() {
                  identityproofController.text = q;
                });
              },
              collection: 'identity_proof',
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            height: height * 0.05,
          ),
        ],
      ),
    );
  }

  Widget _adddoc(height, width) {
    return Container(
      margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
      height: height * 0.13,
      child: Center(
          child: Icon(
        CupertinoIcons.add_circled,
        color: Colors.white,
        size: 25.0,
      )),
      width: width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: Colors.white, width: 1.0)),
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
                      'Welcome to LooksFreak!',
                      style: GoogleFonts.mPlusRounded1c(
                        color: Color(0xff032d3c),
                        fontWeight: FontWeight.w600,
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
                Future.delayed(Duration(seconds: 12))
                    .then((value) => {_completeprofiledialog(context)});
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

  Future<void> _completeprofiledialog(context) async {
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
                      'Please Complete Your LooksFreak Profile',
                      style: GoogleFonts.mPlusRounded1c(
                        color: Color(0xff032d3c),
                        fontWeight: FontWeight.w600,
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
                  height: height * 0.13,
                  width: width * 0.6,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Praesent nec ipsum ut velit mattis tempus non vel nisi.\n In elementum augue luctus dictum fringilla.\n Vivamus quis tincidunt eros.\n Praesent lobortis arcu in placerat scelerisque.',
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

  Future<void> _areyousuredialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return CupertinoAlertDialog(
          title: Column(
            children: [
              Center(
                child: Text(
                  'Application to LooksFreak!',
                  style: GoogleFonts.mPlusRounded1c(
                    color: Color(0xff032d3c),
                    fontWeight: FontWeight.w600,
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
          content: Column(
            children: [
              Container(
                  // margin: EdgeInsets.only(top: height * 0.02),
                  height: height * 0.15,
                  width: width * 0.6,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Are You Sure You Want to\n Submit?',
                      style: GoogleFonts.mPlusRounded1c(
                        color: Color(0xff032d3c),
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.016,
                      ),
                    ),
                  )),
              // SizedBox(height: height * 0.02),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SecondaryButton(
                            title: "Cancel",
                          )),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              loading = true;
                              widget.user.businessname =
                                  _businessnameController.text;
                              widget.user.businesstype = searchController.text;
                              widget.user.opentime =
                                  "${opentime.hour.toString()}:${opentime.minute.toString()} AM";
                              widget.user.closetime =
                                  "${closetime.hour.toString()}:${closetime.minute.toString()}  PM";
                              widget.user.ownersname =
                                  _ownersnameController.text;
                              widget.user.isUptodate = true;
                              widget.user.dateofbirth = _dobController.text;
                              widget.user.shopnumber =
                                  _shopnumberController.text;
                              widget.user.streetnumber =
                                  _streetnameController.text;
                              widget.user.area = _areaController.text;
                              widget.user.town = _townController.text;
                              widget.user.city = _cityController.text;
                              widget.user.state = _stateController.text;
                              widget.user.phonenumber = _mobileController.text;
                              widget.user.country = "Canada";
                              widget.user.businessproof =
                                  businessproofController.text;
                              widget.user.identityproof =
                                  identityproofController.text;
                              widget.user.licensenumber =
                                  _licensenoController.text;
                              widget.user.alternatephonenumber =
                                  _altmobileController.text;
                              widget.user.email = _emailController.text;
                              widget.user.gender = genderController.text;
                            });
                            widget.server.updateUserRecord(widget.user);
                            setState(() {
                              loading = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute<Null>(
                                builder: (context) => StatusPage(),
                              ),
                            );
                          },
                          child: SecondaryButton(
                            title: "Submit",
                          )),
                    ],
                  ),
                  Container(
                      height: loading ? MediaQuery.of(context).size.height : 0,
                      color: Colors.black.withOpacity(0.8),
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffA259FF)),
                      )))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
