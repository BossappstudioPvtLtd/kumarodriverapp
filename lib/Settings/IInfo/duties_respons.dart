// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class DutiesRsp  extends StatefulWidget {
  const DutiesRsp({super.key});

  @override
  State<DutiesRsp> createState() => DutiesRspState();
}

class DutiesRspState extends State<DutiesRsp> {
   final TextEditingController passengerscontroller = TextEditingController(
      text:
          'Driving Passengers: Transporting passengers to their destinations safely and efficiently.'.tr());
  final TextEditingController servicecontroller = TextEditingController(
      text:
          'Customer Service: Providing good customer service, assisting passengers with luggage, and handling payments.'.tr());
           final TextEditingController navigationcontroller = TextEditingController(
      text:
          'Navigation: Knowing the local area well, including alternate routes to avoid traffic or road closures.'.tr());
  final TextEditingController maintenanceController =TextEditingController(text: "Vehicle Maintenance: Keeping the cab clean and in good working condition, performing regular maintenance checks.".tr());

    
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
          title: Text("Duties and Responsibilities".tr()),
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Driving Passengers'.tr(),
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
          TextEdt(
            text: 'Customer Service'.tr(),
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
            height: 20,
          ),
          TextEdt(
            text: 'Navigation'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: navigationcontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(navigationcontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
         
          const SizedBox(
            height: 10,
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
            controller: maintenanceController,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(maintenanceController.text);
              });
            },
            child: const SpeakButton(),
          ),
        ],
      ),
    );
  }
}