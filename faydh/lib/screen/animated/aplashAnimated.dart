import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:faydh/signin.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Splash_Animated extends StatelessWidget {
  const Splash_Animated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/imgs/faydh.png',
      screenFunction: () async {
        return const signInSreen();
      },
      splashIconSize: 1000,
      backgroundColor: const Color(0xFFf7f7f7),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
    );
//small number : the duration will be speed
//large number : the duratiion will be slow);
  }
}
