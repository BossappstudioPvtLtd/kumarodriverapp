// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kumari_drivers/BottamNavigation/profile_edt.dart';
import 'package:kumari_drivers/Settings/Screens/setting_screen.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:kumari_drivers/components/screen_bright.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String _locationMessage = "";

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();

    if (currentUser != null) {
      userRef = FirebaseDatabase.instance
          .reference()
          .child('drivers/${currentUser!.uid}');
    }
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      _locationMessage =
          '${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].country}';
    });
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference? userRef;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: currentUser == null || userRef == null
          ? const Center(child: Text('No user logged in'))
          : StreamBuilder<DatabaseEvent>(
              stream: userRef!.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> event) {
                if (event.hasData &&
                    !event.hasError &&
                    event.data!.snapshot.value != null) {
                  Map data = event.data!.snapshot.value as Map;
                  return SafeArea(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: isSmallScreen ? 20 : 30,
                                    ),
                                    Material(
                                      elevation: 15,
                                      borderRadius: BorderRadius.circular(42),
                                      child: CircleAvatar(
                                        radius: isSmallScreen ? 43 : 42,
                                        backgroundColor: Colors.grey,
                                        child: CircleAvatar(
                                          radius: isSmallScreen ? 90 : 40,
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: Image.network(
                                                  "${data['photo']}",
                                                  width:
                                                      isSmallScreen ? 80 : 75,
                                                  height:
                                                      isSmallScreen ? 80 : 75,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: isSmallScreen ? 10 : 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: isSmallScreen ? 5 : 10),
                                      child: MaterialButton(
                                        height: isSmallScreen ? 40 : 50,
                                        color: Colors.white,
                                        shape: const CircleBorder(),
                                        elevation: 6,
                                        child: const Icon(
                                          Icons.edit,
                                          size: 30,
                                          color:
                                              Color.fromARGB(255, 21, 81, 130),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => PrifileEdt(
                                                name: "${data['name']}"
                                                    .toString(),
                                                email: "${data['email']}"
                                                    .toString(),
                                                phone: "${data['phone']}"
                                                    .toString(),
                                                photo: "${data['photo']}"
                                                    .toString(),
                                                carModel:"${data['car_details']['carModel']}".toString(),
                                                carSeats: data['car_details']['carSeats'].toString(),
                                                carNumber:"${data['car_details']['carNumber']}" .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: isSmallScreen ? 5 : 10),
                                      child: MaterialButton(
                                        height: isSmallScreen ? 40 : 50,
                                        color: Colors.white,
                                        shape: const CircleBorder(),
                                        elevation: 6,
                                        child: const Icon(
                                            Icons.settings_suggest_outlined,
                                            size: 30,
                                            color: Colors.blueGrey),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const Settings(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: isSmallScreen ? 5 : 10),
                                      child: MaterialButton(
                                        height: isSmallScreen ? 40 : 50,
                                        color: Colors.white,
                                        shape: const CircleBorder(),
                                        elevation: 6,
                                        child: Icon(
                                          Icons.wb_sunny_outlined,
                                          size: 30,
                                          color: Colors.green[900],
                                        ),
                                        onPressed: () {
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (builder) {
                                              return const ScreanBrightness();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: isSmallScreen ? 10 : 20,
                                          top: isSmallScreen ? 5 : 10),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                        child: IconButton(
                                          onPressed: () {
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      Colors.black87,
                                                  elevation: 20,
                                                  title: TextEdt(
                                                    text: 'Email Sign Out'.tr(),
                                                    color: Colors.white,
                                                    fontSize: null,
                                                  ),
                                                  content: TextEdt(
                                                    text:
                                                        'Do you want to continue with sign out?'
                                                            .tr(),
                                                    fontSize: null,
                                                    color: Colors.grey,
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        MaterialButtons(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          elevationsize: 20,
                                                          text: '   Cancel    '
                                                              .tr(),
                                                          fontSize: 17,
                                                          containerheight: 40,
                                                          containerwidth: 100,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(10),
                                                          ),
                                                          onPressed: null,
                                                        ),
                                                        MaterialButtons(
                                                          onTap: () {
                                                            _signOut();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          elevationsize: 20,
                                                          text: 'Continue'.tr(),
                                                          fontSize: 17,
                                                          containerheight: 40,
                                                          containerwidth: 100,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(10),
                                                          ),
                                                          onPressed: null,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.power_settings_new,
                                          ),
                                          color: Colors.red,
                                          iconSize: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          25.height,
                          const Divider(
                            height: 1,
                            color: Colors.black,
                            indent: 20,
                            endIndent: 20,
                            thickness: 0.5,
                          ),
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    containerList(
                                        "Current Location".tr(),
                                        _locationMessage,
                                        Icons.my_location,
                                        isSmallScreen),
                                    15.height,
                                    containerList(
                                        "User Name".tr(),
                                        "${data['name']}",
                                        Icons.person,
                                        isSmallScreen),
                                    15.height,
                                    containerList(
                                        "User Email".tr(),
                                        "${data['email']}",
                                        Icons.email,
                                        isSmallScreen),
                                    15.height,
                                    containerList(
                                        "Phone Number".tr(),
                                        "${data['phone']}",
                                        Icons.phone_android_rounded,
                                        isSmallScreen),
                                    15.height,
                                    containerList(
                                        "Car Model".tr(),
                                        "${data['car_details']['carModel']}",
                                        Icons.local_taxi,
                                        isSmallScreen),
                                    15.height,
                                    containerList(
                                        "Car Seats".tr(),
                                        "${data['car_details']['carSeats']}",
                                        Icons
                                            .airline_seat_recline_normal_rounded,
                                        isSmallScreen),
                                    15.height,
                                    containerList(
                                        "Car Number".tr(),
                                        "${data['car_details']['carNumber']}",
                                        Icons.numbers_outlined,
                                        isSmallScreen),
                                    15.height,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }

  Widget containerList(
      String title, String subtitle, IconData icon, bool isSmallScreen) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          onTap: () {},
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 15,
          ),
        ),
      ),
    );
  }
}
