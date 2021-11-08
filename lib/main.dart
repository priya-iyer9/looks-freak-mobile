import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:looksfreak/Auth/login.dart';
import 'package:looksfreak/services/server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Looks Freak',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async {
    // final isloggedin = UserDatabase.checkUser();
    final server =
        Server(app: await Firebase.initializeApp(), context: context);
    // Utils.debugPrint(isloggedin);
    // if (isloggedin) {
    //   final user = (await UserDatabase.getUser()).data;
    //   Utils.debugPrint("user: " + user.toString());
    //   server.createFstoreInstance();
    //   if (user.isUptodate) {
    //     Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => DiscussionsPage(user: user, server: server)));
    //   } else {
    //     Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => FillDetails(user: user, server: server)));
    //   }
    // } else {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login(server: server)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Container(
                    height: 120, child: Image.asset("assets/me.png")))));
  }
}
