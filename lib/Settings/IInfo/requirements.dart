// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Requirements  extends StatefulWidget {
  const Requirements({super.key});

  @override
  State<Requirements> createState() => RequirementsState();
}

class RequirementsState extends State<Requirements> {
   final TextEditingController certificationcontroller = TextEditingController(
      text:
          'Licensing and Certification: Most places require cab drivers to have a special license in addition to a regular drivers license. This often involves:Passing a background check.Completing a taxi driver training program.Passing a written exam and a road test.Obtaining a taxi drivers permit or license.'.tr());
  final TextEditingController experiencecontroller = TextEditingController(
      text:
          'Age and Driving Experience: Typically, cab drivers must be at least 21 years old and have a certain amount of driving experience, often 1-3 years.'.tr());
           final TextEditingController fitnesscontroller = TextEditingController(
      text:
          'Health and Fitness: A medical examination may be required to ensure that the driver is physically capable of operating a taxi safely.'.tr());

    

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
          title: Text("Requirements to Become a Cab Driver".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Licensing and Certification'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: certificationcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(certificationcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Age and Driving Experience'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: experiencecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(experiencecontroller.text);
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