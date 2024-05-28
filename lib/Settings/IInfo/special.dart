// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Special  extends StatefulWidget {
  const Special({super.key});

  @override
  State<Special> createState() => SpecialState();
}

class SpecialState extends State<Special> {
  final TextEditingController passengerscontroller = TextEditingController(text:'The passenger has mention any special requirements such as mobility issues, need for assistance with luggage, etc.'.tr());
  final TextEditingController assistanceneededcontroller = TextEditingController(text:'The passenger will need assistance with luggage at both the pick-up and drop-off locations. Please help with loading and unloading bags.'.tr());
  final TextEditingController specialneedscontroller = TextEditingController(text:'The passenger has mobility issues. Please park as close to the entrance as possible and assist them in and out of the vehicle.If applicable, ensure the wheelchair ramp or other necessary equipment is ready for use.'.tr());
  final TextEditingController communicationcontroller =TextEditingController(text: "The passenger is hearing impaired. Please communicate via text message or written notes if necessary.If the passenger speaks a different language, use the translation app [App Name] to facilitate communication.".tr());
         

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
          title: Text("Special Instuctions".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Passenger Preferences'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: passengerscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(passengerscontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Assistance Needed'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: assistanceneededcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(assistanceneededcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
         
          
          TextEdt(
            text: 'Special Needs'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: specialneedscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(specialneedscontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
         const SizedBox(
            height: 20,
          ),
           TextEdt(
            text: 'Communication'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: communicationcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(communicationcontroller.text);
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