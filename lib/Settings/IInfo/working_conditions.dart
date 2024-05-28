// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class WorkingConditions  extends StatefulWidget {
  const WorkingConditions({super.key});

  @override
  State<WorkingConditions> createState() => WorkingConditionsState();
}

class WorkingConditionsState extends State<WorkingConditions> {
  final TextEditingController hourscontroller = TextEditingController(text:'Hours: Cab drivers often work long and irregular hours, including nights, weekends, and holidays.'.tr());
  final TextEditingController environmentcontroller = TextEditingController(text:'Environment: They spend most of their time on the road, which can be stressful due to traffic, weather conditions, and dealing with various types of passengers.'.tr());
  final TextEditingController flexibilitycontroller = TextEditingController(text:'Flexibility: Some cab drivers enjoy flexible working hours.'.tr());
  final TextEditingController tndependencecontroller =TextEditingController(text: "Independence: Drivers often have a significant degree of independence and autonomy.".tr());
         

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
          title: Text("Working Conditions".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Working Hours'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: hourscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(hourscontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Environment'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: environmentcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(environmentcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Benefits'.tr(),
            fontSize: 30,
            color: null,
          ),
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Flexibility'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: flexibilitycontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(flexibilitycontroller.text);
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
            controller: tndependencecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(tndependencecontroller.text);
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