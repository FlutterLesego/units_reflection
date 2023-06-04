import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//API keys
final String apiKeyAndroid = 'B3256DB7-3199-42CB-BB32-17593B481D1C';
final String apiKeyiOS = '359ED0E1-9055-4B95-BC3F-B9833A507A8F';
final String appID = 'F4F1003B-97B3-67B2-FFE3-D2DDC3494400';
//
//input decoration for forms
InputDecoration formDecoration(String? labelText, IconData? iconData) {
  return InputDecoration(
    errorStyle: const TextStyle(fontSize: 10),
    prefixIcon: Icon(
      iconData,
      color: Colors.green,
    ),
    errorMaxLines: 3,
    labelText: labelText,
    labelStyle: appTextStyle(14, Colors.black, FontWeight.normal),
    enabledBorder: enabledBorder,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
  );
}

const enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    borderSide: BorderSide(width: 1, color: Colors.green));

const focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 2, color: Colors.green));

const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 2, color: Colors.red));

//
//app styles
TextStyle appTextStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.notoSans(fontSize: size, color: color, fontWeight: fw);
}

//
//title text styles
TextStyle titleStyleBlack = const TextStyle(
    fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);

TextStyle titleStyleGreen = const TextStyle(
    fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold);

TextStyle titleStyleWhite = const TextStyle(
    fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

//
//body text styles
TextStyle bodyStyleBlack = const TextStyle(
    fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400);

TextStyle bodyStyleGreen = const TextStyle(
    fontSize: 16, color: Colors.green, fontWeight: FontWeight.w400);

TextStyle bodyStyleWhite = const TextStyle(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400);

//
//sized boxes for adding height between widgets
class SizedBoxH10 extends StatelessWidget {
  const SizedBoxH10({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class SizedBoxH20 extends StatelessWidget {
  const SizedBoxH20({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class SizedBoxH30 extends StatelessWidget {
  const SizedBoxH30({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}

//
//sized boxes for adding width between widgets
class SizedBoxW10 extends StatelessWidget {
  const SizedBoxW10({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 10,
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appTextStyle(26, Colors.black, FontWeight.w900),
    );
  }
}
