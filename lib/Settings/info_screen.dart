import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kumari_drivers/Settings/IInfo/challenges.dart';
import 'package:kumari_drivers/Settings/IInfo/communication.dart';
import 'package:kumari_drivers/Settings/IInfo/duties_respons.dart';
import 'package:kumari_drivers/Settings/IInfo/earnings.dart';
import 'package:kumari_drivers/Settings/IInfo/requirements.dart';
import 'package:kumari_drivers/Settings/IInfo/safety.dart';
import 'package:kumari_drivers/Settings/IInfo/special.dart';
import 'package:kumari_drivers/Settings/IInfo/working_conditions.dart';
import 'package:kumari_drivers/Settings/Settings_Components/forward_button.dart';
import 'package:kumari_drivers/Settings/Settings_Components/settings_item.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Info",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset("assets/images/pngegg (2).png",height: 100,width: 100,),
             
              const SizedBox(height: 50),
              SettingItem(
                title: "Requirements".tr(),
                icon: Ionicons.checkmark_circle_sharp,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: "",
                 child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Requirements(),
                    ),
                  );
                }),
                onTap: () {
                },
              ),
               const SizedBox(height: 20),
               SettingItem(
                title: "Responsibilities".tr(),
                icon: Ionicons.bag_sharp,
                bgColor: Colors.teal.shade100,
                iconColor: Colors.teal,
                value: "",
                child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DutiesRsp(),
                    ),
                  );
                }),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const DutiesRsp()));
                },
              ),
              const SizedBox(height: 20),
               SettingItem(
                title: "Earnings".tr(),
                icon: Ionicons.wallet_sharp,
                bgColor:  Colors.indigo.shade100,
                iconColor: Colors.indigo,
                value: "",
                  child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Requirements(),
                    ),
                  );
                }),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const Earnings()));
                },
              ),
              const SizedBox(height: 20),
               SettingItem(
                title: "Challenges".tr(),
                icon: Ionicons.sparkles_sharp,
                bgColor: Colors.pink.shade100,
                iconColor: Colors.pink,
                value: "",
                  child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Requirements(),
                    ),
                  );
                }),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const Challenges()));
                },
              ),
               const SizedBox(height: 20),
               SettingItem(
                title: "Conditions".tr(),
                icon: Ionicons.timer_sharp,
                bgColor: Color.fromARGB(255, 220, 242, 251),
                iconColor: Colors.blue,
                value: "",
                  child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkingConditions(),
                    ),
                  );
                }),
                onTap: () {
                },
              ),
              
              const SizedBox(height: 50),
               TextEdt(text: "Special Instructions".tr(), color: null, fontSize: 20),
              
              const SizedBox(height: 50),
               SettingItem(
                title: "Special Instructions".tr(),
                icon: Ionicons.color_filter_sharp,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: "",
                  child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Special(),
                    ),
                  );
                }),
                onTap: () {
                },
              ),
               const SizedBox(height: 20),
               SettingItem(
                title: "Safety".tr(),
                icon: Ionicons.shield_checkmark_sharp,
                bgColor: Colors.teal.shade100,
                iconColor: Colors.teal,
                value: "",
                  child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Safety(),
                    ),
                  );
                }),
                onTap: () {
                },
              ),
              const SizedBox(height: 20),
               SettingItem(
                title: "Communication".tr(),
                icon:Icons.record_voice_over_sharp,
                bgColor:  Colors.indigo.shade100,
                iconColor: Colors.indigo,
                value: "",
                  child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Communication(),
                    ),
                  );
                }),
                onTap: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
