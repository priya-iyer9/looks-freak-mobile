import 'dart:convert';
import 'dart:typed_data';

class CustomUser {
  String uid,
      email,
      ownersname,
      businessname,
      businesstype,
      opentime,
      closetime,
      dateofbirth,
      gender,
      type,
      shopnumber,
      streetnumber,
      area,
      town,
      city,
      state,
      country = "Canada",
      licensenumber,
      identityproof,
      phonenumber,
      alternatephonenumber,
      businessproof,
      registrationtype,
      status = "Applied";
  Uint8List ownersimage;

  bool isUptodate, blocked;
  CustomUser({
    this.uid,
    this.email,
    this.ownersname,
    this.businessname,
    this.town,
    this.country,
    this.businesstype,
    this.opentime,
    this.closetime,
    this.status = "Applied",
    this.alternatephonenumber,
    this.area,
    this.blocked = false,
    this.businessproof,
    this.city,
    this.dateofbirth,
    this.gender,
    this.identityproof,
    this.isUptodate = false,
    this.licensenumber,
    this.ownersimage,
    this.phonenumber,
    this.shopnumber,
    this.state,
    this.registrationtype,
    this.streetnumber,
    this.type = "user",
  });

  factory CustomUser.fromJson(json) {
    return CustomUser(
        uid: json["uid"],
        email: json["email"],
        ownersname: json["ownersname"],
        businessname: json["businessname"],
        businesstype: json["businesstype"],
        opentime: json["opentime"],
        closetime: json["closetime"],
        alternatephonenumber: json["alternatephonenumber"],
        area: json["area"],
        status: json["status"],
        country: json["country"],
        businessproof: json["businessproof"],
        city: json["city"],
        type: json["type"],
        registrationtype: json["registrationtype"],
        state: json["state"],
        dateofbirth: json["dateofbirth"],
        gender: json["gender"],
        identityproof: json["identityproof"],
        licensenumber: json["licensenumber"],
        phonenumber: json["phonenumber"],
        shopnumber: json["shopnumber"],
        streetnumber: json["streetnumber"],
        town: json["town"],
        isUptodate: json["isUptodate"] ?? false,
        ownersimage: json["ownersimage"] != null
            ? base64Decode(json["ownersimage"])
            : null,
        blocked: json["blocked"]);
  }
  toJson() {
    return {
      "uid": uid,
      "email": email,
      "ownersname": ownersname,
      "businessname": businessname,
      "businesstype": businesstype,
      "opentime": opentime,
      "closetime": closetime,
      "alternatephonenumber": alternatephonenumber,
      "registrationtype": registrationtype,
      "area": area,
      "status": status,
      "country": country,
      "businessproof": businessproof,
      "city": city,
      "type": type,
      "state": state,
      "dateofbirth": dateofbirth,
      "gender": gender,
      "identityproof": identityproof,
      "licensenumber": licensenumber,
      "phonenumber": phonenumber,
      "shopnumber": shopnumber,
      "streetnumber": streetnumber,
      "town": town,
      "isUptodate": isUptodate,
      "ownersimage": ownersimage != null ? base64Encode(ownersimage) : null,
      "blocked": blocked,
    };
  }
}