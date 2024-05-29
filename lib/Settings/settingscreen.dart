import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kumari_drivers/BottamNavigation/dashbord.dart';
import 'package:kumari_drivers/Settings/Settings_Components/forward_button.dart';
import 'package:kumari_drivers/Settings/Settings_Components/setting_switch.dart';
import 'package:kumari_drivers/Settings/Settings_Components/settings_item.dart';
import 'package:kumari_drivers/Settings/help_screen.dart';
import 'package:kumari_drivers/Settings/info_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  get themeNotifier => null;

  @override
  State<Settings> createState() => _AccountScreenState();
}

class LocalizationChecker {
  static changeLanguage(BuildContext context, Locale newLocale) {
    EasyLocalization.of(context)!.setLocale(newLocale);
  }
}

class _AccountScreenState extends State<Settings> {
  Locale _currentLocale = const Locale('en', 'US');
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const Dashboard()));
//Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings".tr(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Account".tr(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                "Settings".tr(),
                style: const TextStyle(
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
                title: "Dark Mode".tr(),
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
                title: "Language".tr(),
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "",
                child: DropdownButtonHideUnderline(
                  child: Material(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<Locale>(
                          value: _currentLocale,
                          items: const [
                            DropdownMenuItem<Locale>(
                              value: Locale('en', 'US'),
                              child: Text('English'),
                            ),
                            DropdownMenuItem<Locale>(
                              value: Locale('ta', 'IN'),
                              child: Text('Tamil'),
                            ),
                            DropdownMenuItem<Locale>(
                              value: Locale('ml', 'IN'),
                              child: Text('Malayalam'),
                            ),
                          ],
                          onChanged: (Locale? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _currentLocale = newValue;
                                LocalizationChecker.changeLanguage(
                                    context, newValue);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Notifications".tr(),
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
                child: ForwardButton(onTap: () {}),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Help".tr(),
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Help(),
                    ),
                  );
                }),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Info".tr(),
                icon: Ionicons.information_circle,
                bgColor: Colors.green.shade100,
                iconColor: Colors.green,
                child: ForwardButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Info(),
                    ),
                  );
                }),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
