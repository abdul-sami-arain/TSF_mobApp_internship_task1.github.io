import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Head3 extends StatelessWidget {
  final String heading;
  final int R;
  final int G;
  final int B;
  const Head3({
    Key? key, 
    required this.heading,
    required this.R,
    required this.G,
    required this.B
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        style: TextStyle(
            fontSize: 14.sp, color: Color.fromRGBO(R, G, B, 1),letterSpacing: 2,wordSpacing: 2,fontWeight: FontWeight.w700),
        "$heading");
  }
}