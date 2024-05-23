import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Ride extends StatefulWidget {
  const Ride({super.key});

  @override
  State<Ride> createState() => RideState();
}

class RideState extends State<Ride> {
   final TextEditingController downloadcontroller = TextEditingController(
      text:
          'Download the cab driver app from your smartphone’s app store (e.g., kumari cab Driver, Lyft Driver),'
              .tr());
  final TextEditingController createaccountcontroller = TextEditingController(
      text:
          'Create an Account, Sign up using your personal details, email, and phone number.Complete the verification process, which might include submitting documents like your driver’s license, vehicle registration, and insurance.'
              .tr());
  final TextEditingController profilesetupcontroller = TextEditingController(
      text:
          'Upload a professional photo of yourself.Enter your vehicle details (make, model, year, and color).Set your preferences for working hours and payment methods'
              .tr());

  final TextEditingController screencontroller = TextEditingController(
      text:
          'Familiarize yourself with the home screen which typically shows your current location, status (online/offline), and nearby ride requests.'
              .tr());

  final TextEditingController menucontroller = TextEditingController(
      text:
          'Explore the menu to find options like trip history, earnings, ratings, and account settings.'
              .tr());
  final TextEditingController notificationscontroller = TextEditingController(
      text:
          'Learn how to access notifications for ride requests, updates, and messages from the app support team.'
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
            text: 'Download the App'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: downloadcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(downloadcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          TextEdt(
            text: 'Create an Account'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: createaccountcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(createaccountcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Profile Setup'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: profilesetupcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(profilesetupcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Home Screen'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: screencontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(screencontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Menu Option'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: menucontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(menucontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Notifications'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: notificationscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(notificationscontroller.text);
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