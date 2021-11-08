import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:looksfreak/Auth/login.dart';
import 'package:looksfreak/Auth/register.dart';
import 'package:looksfreak/Pages/landing-page.dart';
import 'package:looksfreak/Pages/profile-page.dart';
import 'package:looksfreak/Pages/status-page.dart';
import 'package:looksfreak/services/localDB.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';
import 'package:looksfreak/widgets/buttons.dart';
import 'package:looksfreak/widgets/inputFields.dart';

import 'forgot-password.dart';

class LoginPage extends StatefulWidget {
  final Server server;
  LoginPage({this.server});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController,
      passwordController,
      resetEmailController;
  bool emailError, passwordError, loading, resetEmailError, resetEmailSent;
  String emailErrorText, passwordErrorText, resetEmailErrorText, status;
  FocusNode passwordNode;
  double widget1Opacity = 0.0;
  bool _obscurePass = true;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    resetEmailController = TextEditingController();
    emailError = false;
    passwordError = false;
    loading = false;
    resetEmailSent = false;
    resetEmailError = false;
    emailErrorText = "Email is required";
    passwordErrorText = "Password is required";
    resetEmailErrorText = "Email is required";
    passwordNode = FocusNode();
    initApp();
  }

  initApp() async {
    final a = await Firebase.initializeApp();
    setState(() {
      widget.server.app = a;
    });
    widget.server.createFstoreInstance();
    widget.server.createFauthInstance();
    // Future.delayed(Duration(milliseconds: 300), () {
    widget1Opacity = 1;
    // });
  }

  toEmailVerification(CustomUser user) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CheckOTP(
        user: user,
        server: widget.server,
        email: emailController,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
          child: child,
        );
      },
    ));
  }

  toFillDetails(CustomUser user) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(user: user, server: widget.server)));
  }

  toHome(AuthResponse res, Server server) async {
    await widget.server.setUser(res.user);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Welcome user")));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
              server: widget.server,
              user: res.user,
            )));
  }

  login() async {
    setState(() {
      loading = true;
    });

    String registrationtype = "", area = "", status = "";

    if (widget.server.fauth.currentUser.uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account not found. Please register first")));
    } else {
      final res = await widget.server.login(emailController.value.text.trim(),
          passwordController.value.text.trim());

      print("uid:                  " + res.user.uid.toString() ?? "no uid");
      FirebaseFirestore.instance
          .collection("users")
          .doc(res.user.uid.toString())
          .snapshots()
          .listen((event) {
        setState(() {
          status = event.get("status");
          print("status : " + status);
          area = event.get("area") ?? "";
          print("area : " + area);
          registrationtype = event.get("registrationtype");
          print("registrationtype : " + registrationtype);
        });
      });

      if (widget.server.fauth.currentUser.emailVerified &&
          status == "Approved" &&
          area != null) {
        // ignore: unrelated_type_equality_checks
        // if (status == "Approved") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("welcome user")));
        toHome(res, widget.server);
        // ignore: unrelated_type_equality_checks
      } else if (widget.server.fauth.currentUser.emailVerified &&
          // ignore: unrelated_type_equality_checks
          status == "Applied") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("register user")));
        toFillDetails(res.user);
        // }
      } else if (widget.server.fauth.currentUser.emailVerified &&
          // ignore: unrelated_type_equality_checks
          status == "Approved") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("welcome user")));
        toHome(res, widget.server);
        // }
      } else if (widget.server.fauth.currentUser.emailVerified &&
          // ignore: unrelated_type_equality_checks
          status == "Applied" &&
          area != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              'email found/user uptodate/ status applied/ details filled'),
          duration: const Duration(seconds: 1),
        ));
        await UserDatabase.setUser(res.user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                StatusPage(user: res.user, server: widget.server)));
      } else if (!widget.server.fauth.currentUser.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("email verification pending")));
        toEmailVerification(res.user);
      } else if (widget.server.fauth.currentUser.email.isEmpty &&
          widget.server.fauth.currentUser.uid.toString() == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("user not found")));
        toEmailVerification(res.user);
      } else {
        switch (res.message) {
          case 'user-not-found':
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Account not found. Please register first")));
            setState(() {
              emailError = true;
              emailErrorText = "Account not found. Please register first";
            });
            break;
          case 'wrong-password':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Incorrect password")));
            setState(() {
              passwordError = true;
              passwordErrorText = "Incorrect password";
            });
            break;
        }
      }
    }

    setState(() {
      loading = false;
    });
  }

  forgotPassword() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResetPassword(server: widget.server)));
  }

  register() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Register(server: widget.server)));
  }

  Future<bool> onWillPop() async {
    exit(0);
  }

  void _togglePass() {
    setState(() {
      _obscurePass = !_obscurePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DecoratedBox(
      decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/bg1.jpg"), fit: BoxFit.cover)),
          ),
      child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
              child: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AnimatedOpacity(
                  //   opacity: widget1Opacity,
                  //   duration: Duration(seconds: 4),
                  //   child: Container(
                  //       height: 300,
                  //       width: 300,
                  //       child: Image.asset('assets/login.png')),
                  // ),
                  AnimatedOpacity(
                    opacity: widget1Opacity,
                    duration: Duration(seconds: 4),
                    child: Text("LooksFreak",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                            color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 10),
                    child: InputField(
                      controller: emailController,
                      hint: "Email",
                      obscureText: false,
                      onChanged: (val) {
                        setState(() {
                          emailError = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    child: InputField(
                      controller: passwordController,
                      hint: "Password",
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          passwordError = false;
                        });
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 75),
                        child: GestureDetector(
                          onTap: forgotPassword,
                          child: Text("Forgot Password?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ),
                      )),
                  SizedBox(height: 35.0),
                  GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: PrimaryButton(
                      title: "Login",
                    ),
                  ),
                  SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: register,
                    child: Center(
                      child: Text("Don't Have An Account?",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ],
              )),
              Container(
                  height: loading ? MediaQuery.of(context).size.height : 0,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffA259FF)),
                  )))
            ],
          ))),
    );
  }
}
