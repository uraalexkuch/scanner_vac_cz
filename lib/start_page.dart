import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Container(
          width: 100.w,
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
          child: Stack(children: <Widget>[
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 100),
                              child: Container(
                                height: 30.h,
                                child: Lottie.asset(
                                    'image/39701-robot-bot-3d.json'
                                    //     'https://assets7.lottiefiles.com/packages/lf20_u38thn1f.json'),
                                    ),
                                //Image.asset('image/animation_300_kzbpn6di.gif')
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 500),
                              child: Container(
                                height: 30.h,
                                child: Image.asset('image/logo.png'),
                              ))
                        ],
                      ),
                    ],
                  )),
            ),
            Positioned(
              top: 25.h,
              left: 35.w,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 50,
                  ),
                  width: 30.w,
                  child: RaisedButton(
                    elevation: 10.0,
                    onPressed: () {
                      Get.toNamed('/Home/scanner');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      side: BorderSide(color: HexColor('#FFD947'), width: 3),
                    ),
                    color: HexColor("#005BAA"),
                    focusColor: HexColor('#FFD947'),
                    splashColor: HexColor('#FFD947'),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'image/volnovaha-rayon.png',
                          height: 20.h,
                          width: 40.w,
                        ),
                        Text(
                          "Сканувати",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: HexColor('#FFFFFF'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  top: 500,
                ),
                height: 20.h,
                child: Marquee(
                  text: 'Сканер вакансій',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HexColor('#FFD947'),
                      decoration: TextDecoration.none),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                )),
          ]),
        ),
      );
    });
  }
}
