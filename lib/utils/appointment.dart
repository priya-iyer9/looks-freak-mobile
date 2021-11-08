class Appointment {
  String appointmentid,
      appointmenttime,
      vendorid,
      vendoremail,
      customeremail,
      customername,
      customerphone,
      customerid,
      date,
      reasonofcancel,
      status = "Pending";

  bool canceled = false;
  Appointment({
    this.customeremail,
    this.customerid,
    this.customername,
    this.customerphone,
    this.appointmentid,
    this.appointmenttime,
    this.vendorid,
    this.vendoremail,
    this.canceled = false,
    this.date,
    this.status,
    this.reasonofcancel,
  });

  factory Appointment.fromJson(json) {
    return Appointment(
      vendoremail: json["vendoremail"],
      vendorid: json["vendorid"],
      customeremail: json["customeremail"],
      customerid: json["customerid"],
      customername: json["customername"],
      customerphone: json["customerphone"],
      status: json["status"],
      appointmentid: json["appointmentid"],
      appointmenttime: json["appointmenttime"],
      reasonofcancel: json["reasonofcancel"],
      date: json["date"],
      canceled: json["canceled"] ?? false,
    );
  }
  toJson() {
    return {
      "vendoremail": vendoremail,
      "vendorid": vendorid,
      "customeremail": customeremail,
      "customerid": customerid,
      "customername": customername,
      "customerphone": customerphone,
      "status": status,
      "appointmentid": appointmentid,
      "appointmenttime": appointmenttime,
      "reasonofcancel": reasonofcancel,
      "date": date,
      "canceled": canceled,
    };
  }
}
