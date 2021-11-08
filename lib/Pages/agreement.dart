import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Agreement extends StatefulWidget {
  const Agreement({Key key}) : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Icon(
            CupertinoIcons.refresh_thick,
            color: Colors.black,
          ),
          SizedBox(
            width: width * 0.03,
          ),
        ],
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Agreement",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: Text(
              "LooksFreak User Agreement",
              style: TextStyle(
                fontSize: height * 0.023,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            height: height * 0.7,
            width: width * 0.6,
            child: Expanded(
              child: Column(
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut semper ac arcu id volutpat. Suspendisse potenti. Aenean semper tellus a ipsum mattis, in vestibulum ligula posuere. Donec eget imperdiet magna, et tincidunt eros. Etiam vel commodo ligula. Ut purus arcu, luctus non dapibus a, sagittis non leo. Donec posuere ligula massa, eu vehicula velit fringilla vitae. Sed tincidunt tortor sed leo luctus pretium et ac nisl. Proin quis lacus elementum, euismod ante varius, finibus orci. Suspendisse vulputate sagittis tellus rhoncus rhoncus. Duis commodo luctus felis, faucibus porta nulla consectetur ut. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lacinia scelerisque augue et pellentesque. Aliquam eleifend dui sed massa aliquam, et malesuada justo pretium.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut semper ac arcu id volutpat. Suspendisse potenti. Aenean semper tellus a ipsum mattis, in vestibulum ligula posuere. Donec eget imperdiet magna, et tincidunt eros. Etiam vel commodo ligula. Ut purus arcu, luctus non dapibus a, sagittis non leo. Donec posuere ligula massa, eu vehicula velit fringilla vitae. Sed tincidunt tortor sed leo luctus pretium et ac nisl. Proin quis lacus elementum, euismod ante varius, finibus orci. Suspendisse vulputate sagittis tellus rhoncus rhoncus. Duis commodo luctus felis, faucibus porta nulla consectetur ut. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lacinia scelerisque augue et pellentesque. Aliquam eleifend dui sed massa aliquam, et malesuada justo pretium.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
