import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:looksfreak/Pages/landing-page.dart';
import 'package:looksfreak/Pages/profile-page.dart';
import 'package:looksfreak/services/localDB.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';
import 'package:looksfreak/widgets/buttons.dart';
import 'package:looksfreak/widgets/inputFields.dart';

import 'login.dart';

class Register extends StatefulWidget {
  final Server server;
  Register({this.server});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController ownersNameController,
      emailController,
      passwordController,
      confirmController;
  bool ownersNameError,
      emailError,
      passwordError,
      confirmError,
      loading,
      equalError;
  String emailErrorText;
  FocusNode lastNameNode, emailNode, passwordNode, confirmNode;
  double widget1Opacity = 0.0;
  FirebaseAuth fauth;
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 300), () {
    //   widget1Opacity = 1;
    // });
    ownersNameController = TextEditingController();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    ownersNameError = false;

    emailError = false;
    passwordError = false;
    confirmError = false;
    loading = false;
    equalError = false;
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    confirmNode = FocusNode();
    emailErrorText = "Email is mandatory";
    initApp();
  }

  initApp() async {
    final a = await Firebase.initializeApp();
    setState(() {
      widget.server.app = a;
    });
    widget.server.createFstoreInstance();
  }

  emailCheckDialog() {
    setState(() {
      loading = true;
      equalError = passwordController.value.text.trim() !=
          confirmController.value.text.trim();

      emailError = emailController.value.text.trim() == "";
      passwordError = passwordController.value.text.trim() == "" ||
          equalError ||
          passwordController.value.text.trim().length < 6;
      confirmError = confirmController.value.text.trim() == "" || equalError;
    });
    final isError = ownersNameError ||
        emailError ||
        passwordError ||
        confirmError ||
        equalError;
    if (!isError) {
      register();
    }
    setState(() {
      loading = false;
    });
  }

  register() async {
    // final UserCredential res = (await fauth.createUserWithEmailAndPassword(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim()));
    final res = await widget.server.register(
      emailController.value.text.trim(),
      passwordController.value.text.trim(),
    );

    if (res.user != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Welcome user")));
      toHome(res, widget.server);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email already registered")));
      setState(() {
        emailError = true;
        emailErrorText = "Email already registered";
      });
    }
    setState(() {
      loading = false;
    });
  }

  facebook() async {
    setState(() {
      loading = true;
    });
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken.token);
    final cred = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    final emailExists = await widget.server.checkUserByEmail(cred.user.email);
    if (emailExists.found) {
      if (emailExists.user.isUptodate) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProfilePage(user: emailExists.user, server: widget.server)));
      } else {
        await UserDatabase.setUser(emailExists.user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Home(user: emailExists.user, server: widget.server)));
      }
    } else {
      final CustomUser user = CustomUser(
          ownersname: cred.user.displayName.split(" ").first +
              cred.user.displayName.split(" ").last,
          email: cred.user.email);
      final r = await widget.server.createUserRecord(user);
      if (r.code == DbResponseCode.success) {
        user.uid = r.insertedId;
        setState(() {
          loading = false;
        });
        await UserDatabase.setUser(user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProfilePage(user: user, server: widget.server)));
      }
    }
    setState(() {
      loading = false;
    });
  }

  // onGetUserProfile(UserSucceededAction action) async {
  //   if (action != null) {
  //     final emailExists = await widget.server.checkUserByEmail(
  //         action.user.email.elements[0].handleDeep.emailAddress);
  //     if (emailExists.found) {
  //       await UserDatabase.setUser(emailExists.user);
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => Home(
  //               user: emailExists.user, server: widget.server)));
  //     } else {
  //       final CustomUser user = CustomUser(
  //            ownersname: action.user.displayName.split(" ").first + action.user.displayName.split(" ").last,
  //           email: action.user.email.elements[0].handleDeep.emailAddress);
  //       final r = await widget.server.createUserRecord(user);
  //       if (r.code == DbResponseCode.success) {
  //         user.uid = r.insertedId;
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) =>
  //                 ProfilePage(user: user, server: widget.server)));
  //       }
  //     }
  //   }
  // }

  login() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Login(server: widget.server)));
  }

  toHome(AuthResponse res, Server server) async {
    await widget.server.setUser(res.user);
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CheckOTP(
        user: res.user,
        server: server,
        email: emailController,
        ownersname: ownersNameController,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: Center(
            child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Register here",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: Colors.white)),
                Padding(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 30),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InputField(
                            controller: ownersNameController,
                            hint: "owners Name",
                            obscureText: false,
                            onChanged: (val) {
                              setState(() {
                                ownersNameError = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
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
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                  child: InputField(
                    controller: confirmController,
                    hint: "Confirm Password",
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        confirmError = false;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: emailCheckDialog,
                  child: PrimaryButton(
                    title: "Register",
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: login,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // SocialButtonArea(facebookAction: facebook, linkedinAction: linkedin)
              ],
            )),
            Container(
                height: loading ? MediaQuery.of(context).size.height : 0,
                color: Colors.black.withOpacity(0.8),
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA259FF)),
                )))
          ],
        )));
  }
}

class CheckOTP extends StatefulWidget {
  final TextEditingController ownersname, email;
  final CustomUser user;
  final Server server;
  CheckOTP({this.user, this.server, this.ownersname, @required this.email});
  @override
  _CheckOTPState createState() => _CheckOTPState();
}

class _CheckOTPState extends State<CheckOTP> {
  double widget1Opacity = 0.0;

  @override
  initState() {
    Future.delayed(Duration(milliseconds: 300), () {
      widget1Opacity = 1;
    });
    sendEmail();
    Timer.periodic(Duration(seconds: 2), (timer) {
      checkVerified(timer);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkVerified(Timer timer) async {
    await widget.server.fauth.currentUser.reload();
    if (widget.server.fauth.currentUser.emailVerified) {
      timer.cancel();
      final CustomUser user = CustomUser(
          ownersname: widget.ownersname.text.trim(),
          email: widget.email.text.trim(),
          registrationtype: "EMAIL",
          uid: widget.server.fauth.currentUser.uid.toString(),
          isUptodate: true);
      await widget.server.createUserRecord(user);
      // await widget.server.updateUserRecord(user);
      login();
    }
  }

  sendEmail() async {
    String registrationtype = "";
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.server.fauth.currentUser.uid.toString())
        .snapshots()
        .listen((event) {
      setState(() {
        registrationtype = event.get("registrationtype");
        print("registrationtype : " + registrationtype);
      });
    });
    final emailExists = await widget.server
        .checkUserByEmail(widget.server.fauth.currentUser.email.toString());
    await widget.server.fauth.currentUser.reload();
    if (emailExists.found && registrationtype != "EMAIL") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('You have used another login type'),
        duration: const Duration(seconds: 1),
      ));
    } else if (!emailExists.found) {
      await widget.server.fauth.currentUser.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('registering through email'),
        duration: const Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('error registering'),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  login() async {
    await UserDatabase.setUser(widget.user);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Login(server: widget.server)));
  }

  // toHome() async {
  //   await UserDatabase.setUser(widget.user);
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) =>
  //           Login(user: widget.user, server: widget.server)));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffA259FF)),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "A verification email has been sent to ${widget.user.email}.\n\nPlease do not close the app.",
                    textAlign: TextAlign.center,
                  )
                ],
              )))),
    ));
  }
}
