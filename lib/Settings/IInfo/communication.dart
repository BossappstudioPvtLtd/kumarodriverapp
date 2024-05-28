// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Communication  extends StatefulWidget {
  const Communication({super.key});

  @override
  State<Communication> createState() => CommunicationState();
}

class CommunicationState extends State<Communication> {
  final TextEditingController tripcommunicationcontroller = TextEditingController(text:'Pre-Trip Communication:On the day of the trip, send a confirmation message to [Insert Contact Person’s Name] at [Insert Phone Number] or [Insert Email Address] at least 30 minutes before the scheduled pickup time.If there are any changes to your schedule or any unexpected delays, inform [Insert Contact Person’s Name] immediately.'.tr());
  final TextEditingController duringtripcontroller = TextEditingController(text:'During the Trip:Keep your phone charged and easily accessible for any urgent communication.If you encounter any issues during the trip (e.g., traffic delays, route changes, passenger requests), promptly inform [Insert Contact Person’s Name] at [Insert Phone Number].Use hands-free devices for communication while driving to ensure safety.'.tr());
  final TextEditingController emergencycontactcontroller =TextEditingController(text: "Emergency Contact:In case of an emergency, contact [Insert Name and Phone Number] immediately.Be prepared to provide clear information about the nature of the emergency and your current location.".tr());
  final TextEditingController posttripcontroller = TextEditingController(text: "Post-Trip Communication:After the trip is completed, send a brief message to confirm the successful drop-off of the passenger.Report any incidents or issues encountered during the trip to [Insert Contact Person’s Name] at [Insert Phone Number or Email Address].".tr());     

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
          title: Text("Communication".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Pre-Trip Communication'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: tripcommunicationcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(tripcommunicationcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'During the Trip'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: duringtripcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(duringtripcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
          const SizedBox(
            height: 20,
          ),
         
          
          TextEdt(
            text: 'Emergency Contact'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: emergencycontactcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(emergencycontactcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
         const SizedBox(
            height: 20,
          ),
           TextEdt(
            text: 'Report'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: posttripcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(posttripcontroller.text);
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