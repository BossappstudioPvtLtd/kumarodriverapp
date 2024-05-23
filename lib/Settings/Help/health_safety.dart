// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class HealthSafety  extends StatefulWidget {
  const HealthSafety({super.key});

  @override
  State<HealthSafety> createState() => HealthSafetyState();
}

class HealthSafetyState extends State<HealthSafety> {
   final TextEditingController healthguidelinescontroller = TextEditingController(
      text:
          'Following Health Guidelines Adhere to any health and safety guidelines provided by the app (e.g., wearing masks, sanitizing the vehicle).'
              .tr());
  final TextEditingController safetycontroller = TextEditingController(
      text:
          'Safety Features Familiarize yourself with the app’s safety features, such as emergency assistance or the ability to share your location with trusted contacts.'  .tr());
 
 

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
          title: Text("Setting Up The App".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Following Health Guidelines'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: healthguidelinescontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(healthguidelinescontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          TextEdt(
            text: 'Safety Features'.tr(),
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
         
         
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}