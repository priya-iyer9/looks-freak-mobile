import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looksfreak/services/server.dart';
import 'package:looksfreak/utils/user.dart';

class Appointments extends StatefulWidget {
  final CustomUser user;
  final Server server;
  const Appointments({Key key, this.user, this.server}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Appointments",
              style: GoogleFonts.mPlusRounded1c(
                color: Color(0xff032d3c),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: widget.server.streamAppointments(widget.user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // final target =
                    //     CustomUser.fromJson(snapshot.data.docs[index]);
                    return Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20.0),
                      height: 100.0,
                      width: 400,
                      child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                                "customer email: ${snapshot.data.docs[index]["customeremail"].toString()}\n customer name: ${snapshot.data.docs[index]["customername"].toString()}",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center),
                          ),
                          subtitle: Text(
                              "status: ${snapshot.data.docs[index]["status"].toString()}",
                              textAlign: TextAlign.center)),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    );
                    // return PeopleSearchResult(
                    //     searchResult: target,
                    //     onTap: () => Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //             builder: (context) => ViewProfile(
                    //                 server: widget.server,
                    //                 user: widget.user,
                    //                 target: target))),
                    //     server: widget.server);
                  },
                );
              } else {
                return Center(
                    child: Text("You have no appointments yet\n:(",
                        textAlign: TextAlign.center));
              }
            } else {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA259FF)),
              ));
            }
          },
        ),
      ),
    );
  }
}
