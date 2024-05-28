// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Challenges  extends StatefulWidget {
  const Challenges({super.key});

  @override
  State<Challenges> createState() => ChallengesState();
}

class ChallengesState extends State<Challenges> {
   final TextEditingController safetycontroller = TextEditingController(
      text:
          'Safety: Dealing with potentially dangerous situations, difficult passengers, and the risk of accidents.'.tr());
  final TextEditingController competitioncontroller = TextEditingController(
      text:
          'Competition: Increased competition from ride-sharing services like Uber and Lyft.'.tr());
          final TextEditingController behaviorcontroller = TextEditingController(
      text:
          'Passenger Behavior: Dealing with unruly or aggressive passengers can pose significant safety risks.'.tr());
          final TextEditingController latecontroller =TextEditingController(text: "Late-Night Driving: Driving at night increases the risk of encountering criminal activities or accidents.".tr());
         

  Language initialLang = Language('en', 'English');
  var langList = [];
  var selectedLang;

  @override
  void initState() {
    //langList.clear();
    tts.getVoices.then((value) {
      for (int i = 0; i < value.length; i++) {
        langList.add(value[i]['locale']);
        print(value[i]['locale']);
        print(langList.length);
      }
    });
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text("Challenges".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Safety'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: safetycontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(safetycontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Competition'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: competitioncontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(competitioncontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
          
          TextEdt(
            text: 'Passenger Behavior'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: behaviorcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(behaviorcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
         const SizedBox(
            height: 20,
          ),
           TextEdt(
            text: 'Late-Night Driving'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: latecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(latecontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
         const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}