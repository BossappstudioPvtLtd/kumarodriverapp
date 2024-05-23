import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kumari_drivers/Settings/Settings_Components/setting_switch.dart';
import 'package:kumari_drivers/Settings/Settings_Components/settings_item.dart';
import 'package:kumari_drivers/Settings/help_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<Settings> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SettingSwitch(
                title: "Dark Mode",
                icon: Ionicons.sunny_sharp,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Notifications",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Help",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const Help()));
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Info",
                icon: Ionicons.information_circle,
                bgColor: Colors.green.shade100,
                iconColor: Colors.green,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
