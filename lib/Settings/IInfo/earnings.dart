// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_textfield.dart';
import 'package:kumari_drivers/components/speek_button.dart';
import 'package:language_picker/languages.dart';

class Earnings  extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => EarningsState();
}

class EarningsState extends State<Earnings> {
   final TextEditingController wagescontroller = TextEditingController(
      text:
          'Wages: Earnings can vary widely based on location, hours worked, and whether the driver owns their cab or leases it. Tips can also be a significant part of a cab drivers income.'.tr());
  final TextEditingController expensescontroller = TextEditingController(
      text:
          'Expenses: Drivers may be responsible for fuel, maintenance, insurance, and lease fees if they do not own their vehicle.'.tr());
         

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
            text: 'Wages'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: wagescontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(wagescontroller.text);
              });
            },
            child: const SpeakButton(),
          ),
           const SizedBox(
            height: 20,
          ),
          TextEdt(
            text: 'Expenses'.tr(),
            fontSize: 16,
            color: null,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialTextField(
            controller: expensescontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                tts.speak(expensescontroller.text);
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