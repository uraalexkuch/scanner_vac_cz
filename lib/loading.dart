import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loading extends StatelessWidget {
  // final SpringController springController = SpringController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment(0.0, -0.3),
            end: Alignment(1.0, 0.1),
            colors: [
              Color(0xff100b63),
              Color(0xff2196f3),
            ],
            stops: [
              0,
              1,
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 40.0.h),
            child: Column(children: [
              CircularProgressIndicator(
                backgroundColor: HexColor('#FFD947'),
              ),
              Text(
                "Зачекайте, завантажую",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Helvetica",
                  fontSize: 20.sp,
                  color: HexColor('#FFD947'),
                ),
              ),
            ]),
          ),
        ),
      ));
    });
  }
}
