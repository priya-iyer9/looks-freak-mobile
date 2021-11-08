import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:looksfreak/Auth/login2.dart';
import 'package:looksfreak/Auth/phone-login1.dart';
import 'package:looksfreak/Auth/register.dart';
import 'package:looksfreak/Pages/status-page.dart';
import 'package:looksfreak/Pages/landing-page.dart';
import 'package:looksfreak/Pages/profile-page.dart';
import 'package:looksfreak/services/localDB.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';
import 'package:looksfreak/widgets/buttons.dart';

class Login extends StatefulWidget {
  final Server server;
  const Login({Key key, this.server}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
    initApp();
  }

  initApp() async {
    final a = await Firebase.initializeApp();
    setState(() {
      widget.server.app = a;
    });
    widget.server.createFstoreInstance();
    widget.server.createFauthInstance();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        height: height * 0.1,
        width: width,
        child: Center(
          child: Text(
            "LooksFreak Terms & Conditions",
            style: GoogleFonts.mPlusRounded1c(
              letterSpacing: 1.0,
              color: Color(0xfff7ff56),
              fontWeight: FontWeight.w800,
              fontSize: height * 0.022,
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xff032d3c),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Center(
            child: Text(
              "LooksFreak",
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 2.0,
                color: Colors.white,
                fontSize: height * 0.03,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Center(
            child: Text(
              "Welcome To LooksFreak",
              style: GoogleFonts.mPlusRounded1c(
                letterSpacing: 1.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: height * 0.022,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Null>(
                    builder: (context) => LoginPage(
                      server: widget.server,
                    ),
                  ),
                );
              },
              child: PrimaryButton(
                title: "Sign In With Email",
              )),
          SizedBox(
            height: height * 0.03,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Null>(
                    builder: (context) => PhoneLogin(
                      server: widget.server,
                    ),
                  ),
                );
              },
              child: PrimaryButton(
                title: "Sign In With Phone",
              )),
          SizedBox(
            height: height * 0.2,
          ),
          // GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         CupertinoPageRoute<Null>(
          //           builder: (context) => Register(),
          //         ),
          //       );
          //     },
          //     child: _button(height, width, "Register")),
          // SizedBox(
          //   height: height * 0.18,
          // ),
          _googlelogintile(height, width, context),
          SizedBox(
            height: height * 0.02,
          ),
          _facebooklogintile(height, width, context),
        ],
      ),
    );
  }

  Widget _googlelogintile(height, width, context) {
    return GestureDetector(
      onTap: () {
        signInWithGoogle(context);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: width * 0.21, right: width * 0.2, top: height * 0.01),
            height: height * 0.05,
            width: width * 0.56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Text(
                    "Connect With Google",
                    style: TextStyle(
                        color: Color(0xff032d3c),
                        fontSize: height * 0.015,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: width * 0.5, left: width * 0.2),
            height: height * 0.07,
            width: width * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.5),
              color: Colors.white,
            ),
            child: Image.asset("assets/google.png", height: height * 0.03),
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signInWithGoogle(context) async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );

        final emailExists = await widget.server
            .checkUserByEmail(userCredential.user.email.toString());
        String registrationtype = "", status = "Applied", area = "";
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.server.fauth.currentUser.uid.toString())
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
        if (emailExists.found &&
            !emailExists.user.isUptodate &&
            status == "Applied") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('email exists/user not uptodate/gmail login'),
            duration: const Duration(seconds: 1),
          ));
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(user: emailExists.user, server: widget.server)));
        } else if (emailExists.found &&
            emailExists.user.isUptodate &&
            status == "Applied" &&
            area != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
                'email found/user uptodate/ status applied/ details filled'),
            duration: const Duration(seconds: 1),
          ));
          await UserDatabase.setUser(emailExists.user);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  StatusPage(user: emailExists.user, server: widget.server)));
        } else if (emailExists.found &&
            emailExists.user.isUptodate &&
            status == "Approved" &&
            area != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('email found/user uptodate/ gmail login'),
            duration: const Duration(seconds: 1),
          ));
          await UserDatabase.setUser(emailExists.user);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Home(user: emailExists.user, server: widget.server)));
        } else if (!emailExists.found) {
          final name = userCredential.user.displayName.split(" ");
          final CustomUser user = CustomUser(
              ownersname: name.first + name.last,
              uid: widget.server.fauth.currentUser.uid.toString(),
              registrationtype: "GMAIL",
              email: userCredential.user.email);
          final r = await widget.server.createUserRecord(user);
          if (r.code == DbResponseCode.success) {
            user.uid = r.insertedId;
            await UserDatabase.setUser(user);
            setState(() {
              loading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('user does not exist/create user'),
              duration: const Duration(seconds: 1),
            ));
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProfilePage(user: user, server: widget.server)));
          } else if (emailExists.found && registrationtype != "GMAIL") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('You have used another login type'),
              duration: const Duration(seconds: 1),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('error signing in/ try again'),
              duration: const Duration(seconds: 1),
            ));
          }
        }

        setState(() {
          loading = false;
        });

        return userCredential.user;
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
  }

  Widget _facebooklogintile(height, width, context) {
    return GestureDetector(
      onTap: () {
        facebook(context);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: width * 0.2, right: width * 0.19, top: height * 0.01),
            height: height * 0.05,
            width: width * 0.55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.053),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: width * 0.043),
                  child: Text(
                    "Connect With Facebook",
                    style: TextStyle(
                        color: Color(0xff032d3c),
                        fontSize: height * 0.015,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.63, right: width * 0.2),
            height: height * 0.07,
            width: width * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.5),
              color: Colors.white,
            ),
            child: Image.asset("assets/facebook.png", height: height * 0.03),
          ),
        ],
      ),
    );
  }

  facebook(context) async {
    setState(() {
      loading = true;
    });
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken.token);
    final cred = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    final emailExists =
        await widget.server.checkUserByEmail(cred.user.email.toString());
    String registrationtype = "", status = "Applied", area = "";
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.server.fauth.currentUser.uid.toString())
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
    if (cred.user.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('please sign in to your facebook account'),
        duration: const Duration(seconds: 1),
      ));
    } else {
      if (emailExists.found &&
          !emailExists.user.isUptodate &&
          status == "Applied") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('email exists/user not uptodate/gmail login'),
          duration: const Duration(seconds: 1),
        ));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProfilePage(user: emailExists.user, server: widget.server)));
      } else if (emailExists.found &&
          emailExists.user.isUptodate &&
          status == "Applied" &&
          area != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              'email found/user uptodate/ status applied/ details filled'),
          duration: const Duration(seconds: 1),
        ));
        await UserDatabase.setUser(emailExists.user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                StatusPage(user: emailExists.user, server: widget.server)));
      } else if (emailExists.found &&
          emailExists.user.isUptodate &&
          status == "Approved" &&
          area != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('email found/user uptodate/ gmail login'),
          duration: const Duration(seconds: 1),
        ));
        await UserDatabase.setUser(emailExists.user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Home(user: emailExists.user, server: widget.server)));
      } else if (!emailExists.found) {
        final name = cred.user.displayName.split(" ");
        final CustomUser user = CustomUser(
            ownersname: name.first + name.last,
            uid: widget.server.fauth.currentUser.uid.toString(),
            registrationtype: "FACEBOOK",
            email: cred.user.email);
        final r = await widget.server.createUserRecord(user);
        if (r.code == DbResponseCode.success) {
          user.uid = r.insertedId;
          await UserDatabase.setUser(user);
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('user does not exist/create user'),
            duration: const Duration(seconds: 1),
          ));
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(user: user, server: widget.server)));
        } else if (emailExists.found && registrationtype != "FACEBOOK") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('You have used another login type'),
            duration: const Duration(seconds: 1),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('error signing in/ try again'),
            duration: const Duration(seconds: 1),
          ));
        }
      }
    }
  }
}
