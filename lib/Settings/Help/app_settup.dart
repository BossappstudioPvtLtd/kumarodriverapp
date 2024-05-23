// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

final FlutterTts tts = FlutterTts();

class AppSettUp extends StatefulWidget {
  const AppSettUp({
    super.key,
  });

  @override
  AppSettUpState createState() => AppSettUpState();
}

class AppSettUpState extends State<AppSettUp> {
  final TextEditingController goingonlinecontroller = TextEditingController(
      text:
          'Going Online Toggle the status to “Online” to start receiving ride requests.'
              .tr());
  final TextEditingController receivingridecontroller = TextEditingController(
      text:
          'Receiving Ride RequestsWhen a ride request comes in, the app will alert you with a sound or vibration.Quickly review the request details (pickup location, estimated fare) and accept or decline it.'
              .tr());
  final TextEditingController navigatingcontroller = TextEditingController(
      text:
          'Navigating to the Pickup Locationapp’s built-in navigation to reach the passenger’s location.Communicate with the passenger if you encounter any issues finding them (e.g., use the in-app messaging or call feature).'
              .tr());

  final TextEditingController startridecontroller = TextEditingController(
      text:
          'Starting the RideOnce the passenger is in the car, start the trip in the app.Confirm the destination and follow the suggested route unless the passenger requests a specific route..'
              .tr());

  final TextEditingController duringcontroller = TextEditingController(
      text:
          'During the RideDrive safely and adhere to traffic laws.Engage in polite conversation if the passenger is open to it, but respect their preference for quiet if they seem disinterested..'
              .tr());
  final TextEditingController endingcontroller = TextEditingController(
      text:
          'Ending the RideConfirm arrival at the destination in the app.Ensure the passenger has all their belongings before they leave..'
              .tr());

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
    return Scaffold(
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
            text: 'Going Online '.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: goingonlinecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(goingonlinecontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          TextEdt(
            text: 'Receiving Ride'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: receivingridecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(receivingridecontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Navigating'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: navigatingcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(navigatingcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Start Ride'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: startridecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(startridecontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'During the RideDrive'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: duringcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(duringcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Ending the Ride'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: endingcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(endingcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
