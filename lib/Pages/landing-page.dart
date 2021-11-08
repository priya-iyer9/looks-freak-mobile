import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looksfreak/Pages/my-appointments.dart';
import 'package:looksfreak/Pages/my-shop.dart';
import 'package:looksfreak/Pages/my-profile.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';

class Home extends StatefulWidget {
  final CustomUser user;
  final Server server;
  Home({Key key, this.user, this.server}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Server server; //New
  List<Widget> _pages = <Widget>[];
//New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      Appointments(
        server: widget.server,
        user: widget.user,
      ),
      MyShop(
        server: widget.server,
        user: widget.user,
      )
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        // backgroundColor: Color(0xff032d3c),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          unselectedLabelStyle: GoogleFonts.mPlusRounded1c(
            color: Color(0xff032d3c),
            fontWeight: FontWeight.w600,
            fontSize: height * 0.014,
          ),
          selectedLabelStyle: GoogleFonts.mPlusRounded1c(
            color: Color(0xff032d3c),
            fontWeight: FontWeight.w800,
            fontSize: height * 0.0185,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              tooltip: "Appointments Recieved/Booked",
              activeIcon: Icon(Icons.note_alt_rounded,
                  color: Color(0xff032d3c), size: 25.0),
              icon: Icon(Icons.note_alt_outlined,
                  color: Colors.grey.shade300, size: 20.0),
              label: 'My Appointments',
            ),
            BottomNavigationBarItem(
              tooltip: "Shop Details & Listings",
              activeIcon: Icon(Icons.shopping_bag_rounded,
                  color: Color(0xff032d3c), size: 25.0),
              icon: Icon(Icons.shopping_bag_outlined,
                  color: Colors.grey.shade300, size: 20.0),
              label: 'My Shop',
            ),
            // BottomNavigationBarItem(
            //   tooltip: "Profile Details & Form",
            //   activeIcon: Icon(Icons.person_rounded,
            //       color: Color(0xff032d3c), size: 25.0),
            //   icon: Icon(Icons.person_outline_rounded,
            //       color: Colors.grey.shade300, size: 20.0),
            //   label: 'My Profile',
            // ),
          ],
        ),
      ),
    );
  }
}
