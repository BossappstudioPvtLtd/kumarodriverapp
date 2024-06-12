// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AnimationButton extends StatelessWidget {
  final void Function()? onTap;
  const AnimationButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: const Color.fromARGB(255, 15, 6, 77),
      elevation: 10,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: screenHeight * 0.07, // 7% of screen height
          width: screenWidth * 0.5, // 50% of screen width
          child: const Center(
            child: Text(
              "Let's get started!",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
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
              reverseCurve: Curves.fastOutSlowIn,
            );
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: child,
            );
          },
        );
}
