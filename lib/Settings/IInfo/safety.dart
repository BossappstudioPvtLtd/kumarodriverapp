// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Safety  extends StatefulWidget {
  const Safety({super.key});

  @override
  State<Safety> createState() => SafetyState();
}

class SafetyState extends State<Safety> {
  final TextEditingController maintenancecontroller = TextEditingController(text:'Vehicle Maintenance:Ensure the vehicle is in excellent working condition.Perform a safety check before the trip, including brakes, lights, tires, and fluid levels.'.tr());
  final TextEditingController precautionscontroller = TextEditingController(text:'COVID-19 Precautions:Sanitize the vehicle before and after each trip.Ensure passengers wear masks if required.Provide hand sanitizer in the vehicle.'.tr());
  final TextEditingController drivingsafetycontroller = TextEditingController(text:'Driving Safety:Always wear your seat belt and ensure all passengers do the same.Adhere to all traffic laws and speed limits.Avoid using your phone while driving; use hands-free options if necessary.'.tr());
  final TextEditingController passengersafetycontroller =TextEditingController(text: "Passenger Safety:Assist passengers with entering and exiting the vehicle, especially those with mobility issues.Store luggage securely to prevent movement during transit.Ensure child safety seats are installed and used correctly if transporting young children.".tr());
         

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
          title: Text("Safety".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Vehicle Maintenance'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: maintenancecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(maintenancecontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'COVID-19 Precautions'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: precautionscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(precautionscontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
        
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Driving Safety'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: drivingsafetycontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(drivingsafetycontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
         const SizedBox(
            height: 20,
          ),
           TextEdt(
            text: 'Passenger Safety'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: passengersafetycontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(passengersafetycontroller.text);
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