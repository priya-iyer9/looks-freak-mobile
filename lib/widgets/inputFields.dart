import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  Function(String) onChanged;
  Function(String) validator;
  TextEditingController controller;
  bool obscureText, enabled, readOnly;
  String hint, initialValue;
  int maxlength;
  TextInputType keyboardType;

  InputField({
    this.maxlength,
    this.readOnly = false,
    this.onChanged,
    this.controller,
    this.obscureText,
    this.validator,
    this.hint,
    this.enabled,
    this.keyboardType,
    this.initialValue,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
      child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(3.0),
          ),
          color: Colors.transparent,
          child: TextFormField(
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            maxLength: widget.maxlength,
            enableInteractiveSelection: true,
            enabled: widget.enabled,
            toolbarOptions: ToolbarOptions(
                copy: true, paste: true, cut: true, selectAll: true),
            obscureText: widget.obscureText ?? false,
            onChanged: widget.onChanged,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            style: TextStyle(
              fontSize: 15.4,
              color: Colors.white,
            ),
            validator: widget.validator,
            cursorColor: Color(0xff77ACF1),
            cursorWidth: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              counterStyle: TextStyle(
                fontSize: 9,
                color: Colors.white,
              ),
              hintText: widget.hint.toString(),
              hintStyle: TextStyle(
                fontSize: 15.4,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: false,
              contentPadding: EdgeInsets.all(15),
            ),
          )),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  // final List<String> items;
  final String text;
  final String hint;
  final String collection;
  final Function(String) onChanged;
  final bool error;
  CustomDropDown(
      {this.onChanged,
      this.text,
      this.hint,
      this.error,
      @required this.collection});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DropdownMenuItem<String>> _list = [];
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot snap = snapshot.data.docs[i];
            _list.add(
              DropdownMenuItem<String>(
                child: Text(snap.id),
                value: "${snap.id}",
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
                color: Color(0xffE0E0E0),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Color(0xfff0f0f0),
                elevation: 0,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                hint: Text(text == null ? hint : text.toString(),
                    style: TextStyle(color: Color(0xff032d3c), fontSize: 13)),
                underline: Container(),
                icon: Icon(Icons.keyboard_arrow_down_sharp,
                    color: Color(0xffa4a4a4)),
                items: _list,
                onChanged: onChanged,
              ),
            ),
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}
