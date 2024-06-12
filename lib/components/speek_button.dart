import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SpeakButton extends StatelessWidget {
  const SpeakButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen width
    var screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: isSmallScreen ? 35 : 45,
          width: isSmallScreen ? 100 : 130,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.indigo.shade400,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.record_voice_over_outlined,
                color: Colors.white,
              ),
              SizedBox(width: isSmallScreen ? 5 : 10),
              Text(
                "Speak".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 14 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
