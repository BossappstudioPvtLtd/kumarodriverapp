import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kumari_drivers/Settings/Help/app_settup.dart';
import 'package:kumari_drivers/Settings/Help/health_safety.dart';
import 'package:kumari_drivers/Settings/Help/ride.dart';
import 'package:kumari_drivers/Settings/Settings_Components/settings_item.dart';
import 'package:kumari_drivers/Settings/Help/managing%20.dart';
import 'package:kumari_drivers/Settings/settingscreen.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(38),
          child: Column(
            children: [
              const Text(
                "Help",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset("assets/images/pngegg.png",height: 80,width: 80,),
              const Text(
                "1545848454",
                style: TextStyle(
                  
                  fontWeight: FontWeight.bold,
                ),

              ),
              const Text(
                "cs@kumaricabs",
                style: TextStyle(
                
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              SettingItem(
                title: "App SettUp",
                icon: Ionicons.book,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: "",
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const AppSettUp()));
                },
              ),
               const SizedBox(height: 20),
               SettingItem(
                title: "Ride",
                icon: Ionicons.car_sport_sharp,
                bgColor: Colors.teal.shade100,
                iconColor: Colors.teal,
                value: "",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const Ride()));
                },
              ),
              const SizedBox(height: 20),
               SettingItem(
                title: "Managing",
                icon: Ionicons.cash_sharp,
                bgColor:  Colors.indigo.shade100,
                iconColor: Colors.indigo,
                value: "",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const Managing()));
                },
              ),
              const SizedBox(height: 20),
               SettingItem(
                title: "Safety and Accident",
                icon: Ionicons.shield_checkmark_sharp,
                bgColor: Colors.pink.shade100,
                iconColor: Colors.pink,
                value: "",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const HealthSafety()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
