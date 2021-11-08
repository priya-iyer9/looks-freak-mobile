import 'package:flutter/material.dart';

class BlockedList extends StatefulWidget {
  const BlockedList({Key key}) : super(key: key);

  @override
  _BlockedListState createState() => _BlockedListState();
}

class _BlockedListState extends State<BlockedList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Block List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          // Center(
          //   child: Image.asset(
          //     "assets/cat2.png",
          //     height: height * 0.17,
          //   ),
          // ),
          // SizedBox(
          //   height: height * 0.02,
          // ),
          Center(
            child: Text(
              "Blocked List is empty",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: height * 0.024,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
