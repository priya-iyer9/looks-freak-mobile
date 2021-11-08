final RegExp emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);
final RegExp passwordRegExp = RegExp(
  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
);

final RegExp phoneNumber = RegExp(
  r'^(\+[9][1])([0-9]{10})$',
);

isValidEmail(String email) {
  return emailRegExp.hasMatch(email);
}

isValidPassword(String password) {
  return passwordRegExp.hasMatch(password);
}

isValidPhoneNumber(String value) {
  return phoneNumber.hasMatch(value);
}
