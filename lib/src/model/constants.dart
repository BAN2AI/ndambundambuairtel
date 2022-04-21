import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFEA0E00);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFEA0E00), Color(0xFFEA0E00)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Entrez une adresse email";
const String kInvalidEmailError = "Entrez une adresse email valide";
const String kPassNullError = "SVP Enter votre mot de pass";
const String kShortPassError = "Mot de passe tres court";
const String kMatchPassError = "Les mots de passe ne correspondent pas";
const String kNamelNullError = "Svp Entrez votre nom";
const String kPhoneNumberNullError = "Entrez votre numero de telephone";
const String kAddressNullError = "Entrez votre adresse";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
