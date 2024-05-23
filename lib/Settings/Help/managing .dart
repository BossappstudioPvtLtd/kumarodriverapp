// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Managing  extends StatefulWidget {
  const Managing({super.key});

  @override
  State<Managing> createState() => ManagingState();
}

class ManagingState extends State<Managing> {
   final TextEditingController farecalculationcontroller = TextEditingController(
      text:
          'Fare Calculation The app will automatically calculate the fare based on distance, time, and any applicable surcharges (e.g., surge pricing).'
              .tr());
  final TextEditingController paymentscontroller = TextEditingController(
      text:
          'Receiving Payments Payments are typically processed through the app, with the fare being credited to your account.If the passenger opts to pay in cash (if the app supports this), collect the exact amount and confirm receipt in the app.'  .tr());
  final TextEditingController servicecontroller = TextEditingController(
      text:
          'Customer Service Be polite, professional, and helpful.Maintain a clean and comfortable vehicle.g'.tr());

  final TextEditingController trackingcontroller = TextEditingController(
      text:
          'Tracking Earnings Regularly check the “Earnings” section in the app to monitor your income.Understand how much you earn per trip and any deductions (e.g., service fees).' .tr());

  final TextEditingController updatedcontroller = TextEditingController(
      text:
          'Staying UpdatedApp Updates Regularly update the app to the latest version to access new features and security improvements.Policy Changes Stay informed about any changes in the app’s policies, fare structures, or terms of service.Driver Support Utilize the app’s help center or customer support for any issues or questions.Participate in any available training or information sessions offered by the app company..'
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
            text: 'Farecal Culation'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: farecalculationcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(farecalculationcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          TextEdt(
            text: 'Receiving Payments'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: paymentscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(paymentscontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Maintaining a Good Rating'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: servicecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(servicecontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Tracking Earnings'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: trackingcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(trackingcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 10,
          ),
          TextEdt(
            text: 'Update'.tr(),
            fontSize: 16,
            color: null,
          ),
          MaterialTextField(
            controller: updatedcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(updatedcontroller.text);
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