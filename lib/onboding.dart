// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kumari_drivers/AuthService/auth_gate.dart';
import 'package:kumari_drivers/components/animation_Buttons.dart';
import 'package:kumari_drivers/components/image_add.dart';
import 'package:kumari_drivers/components/text_animation.dart';
import 'package:nb_utils/nb_utils.dart';

class OnBoding extends StatefulWidget {
  const OnBoding({super.key});

  @override
  State<OnBoding> createState() => _OnBodingState();
}

class _OnBodingState extends State<OnBoding> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 193, 7),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        child: Stack(
          children: [
            25.height,
            Image.asset(
              "assets/logo/onboard.png",
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
            
            25.height,
            ListView(
              children: [
                Center(
                  child: ImageAdd(
                    image: "assets/logo/Driver app.png",
                    height: screenHeight * 0.5,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ), 
                25.height,
                const TextAnimation(),
                 25.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: AnimationButton(
                    onTap: () => Navigator.push(
                      context,
                      ScaleTransition1(
                        const Authgate(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScaleTransition1 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: child,
            );
          },
        );
}
