import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController slideAnimation;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> textAnimation;

  @override
  void initState() {
    // animationController = AnimationController(vsync: this,
    //     lowerBound: 0,
    //     upperBound: 60,
    //     animationBehavior: AnimationBehavior.normal,
    //     duration: Duration(milliseconds: 700));
    //
    // animationController.forward();
    // slideAnimation = AnimationController(vsync: this,
    //     duration:  Duration(milliseconds: 700));
    //
    // offsetAnimation = Tween<Offset>(
    //     begin: Offset.zero,
    //     end: Offset(-0.5,0.0)
    // ).animate(CurvedAnimation(
    //     parent: slideAnimation,
    //     curve: Curves.fastOutSlowIn));
    //
    // textAnimation = Tween<Offset>(
    //     begin: Offset(-0.5,0.0),
    //     end: Offset(0.2,0.0)
    // ).animate(CurvedAnimation(
    //     parent: slideAnimation,
    //     curve: Curves.fastOutSlowIn));
    //
    // animationController.addStatusListener((status){
    //   if(status == AnimationStatus.completed){
    //     slideAnimation.forward();
    //   }
    // });

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homepage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: 600,
            width: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("picture/ai.gif"), fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}
