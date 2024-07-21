import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_clock/flutter_flip_clock.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kumari_drivers/AuthanticationPages/login.dart';
import 'package:kumari_drivers/Const/geokey.dart';
import 'package:kumari_drivers/Subscription/driver_avl.dart';
import 'package:kumari_drivers/Subscription/subscription.dart';
import 'package:kumari_drivers/Subscription/subscription_provider.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:kumari_drivers/pushNotification/push_notification_system.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> with WidgetsBindingObserver {
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currentPositionOfUser;
  Color colorToShow = Colors.green;
  String titleToShow = "GO ONLINE NOW";
  String userName = "";
  bool isDriverAvailable = false;
  DatabaseReference? newTripRequestReference;
  late StreamSubscription<Position> positionStreamHomePage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeGeoFireListener();
    initializePushNotificationSystem();
    getUserCurrentLocation();
    getUserInfoAndCheckBlockStatus();
   
    checkSubscriptionTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getUserInfoAndCheckBlockStatus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    positionStreamHomePage.cancel();
    super.dispose();
  }

  Future<void> getUserInfoAndCheckBlockStatus() async {
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snap = await usersRef.once();

    if (snap.snapshot.value != null) {
      final userData = snap.snapshot.value as Map;
      if (userData["blockStatus"] == "no") {
        setState(() {
          userName = userData["name"];
        });
      } else {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => const LoginScreen()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("You are blocked. Contact admin: Kumariacabs@gmail.com")));
      }
    } else {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const LoginScreen()));
    }
  }
  

  void initializeGeoFireListener() {
    // Your GeoFire initialization code here
  }

  void checkSubscriptionTimer() {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    final driverAvailability =
        Provider.of<DriverAvailability>(context, listen: false);

    // Listen to changes in subscriptionProvider.secondsLeft
    subscriptionProvider.addListener(() {
      if (subscriptionProvider.secondsLeft == 0 &&
          driverAvailability.isDriverAvailable) {
        driverAvailability.toggleAvailability();
        goOfflineNow();
        setState(() {
          isDriverAvailable = false;
        });
      }
    });
  }
  

  // Method to go online
  void goOnlineNow() {
    Geofire.initialize("onlineDrivers");
    Geofire.setLocation(
      FirebaseAuth.instance.currentUser!.uid,
      currentPositionOfUser!.latitude,
      currentPositionOfUser!.longitude,
    );

    newTripRequestReference = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("newTripStatus");
    newTripRequestReference!.set("waiting");

    newTripRequestReference!.onValue.listen((event) {});
  }

  // Method to go offline
  void goOfflineNow() {
    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);
    newTripRequestReference!.onDisconnect();
    newTripRequestReference!.remove();
    newTripRequestReference = null;
  }

  // Method to get user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  // Method to get current live location of driver
  void getCurrentLiveLocationOfDriver() async {
    Position positionOfUser = await 
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);currentPositionOfUser = positionOfUser;
    LatLng positionOfUserInLatLng = LatLng(currentPositionOfUser!.latitude, currentPositionOfUser!.longitude);
    CameraPosition cameraPosition = CameraPosition(target: positionOfUserInLatLng, zoom: 15);
    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  setAndGetLocationUpdates() {
    positionStreamHomePage =Geolocator.getPositionStream().listen((Position position) {
      currentPositionOfUser = position;if (isDriverAvailable) { Geofire.setLocation(FirebaseAuth.instance.currentUser!.uid,
          currentPositionOfUser!.latitude,
          currentPositionOfUser!.longitude,
        );
      }
      LatLng positionLatLng = LatLng(position.latitude, position.longitude);
      controllerGoogleMap!.animateCamera(CameraUpdate.newLatLng(positionLatLng));
    });
  }

  initializePushNotificationSystem()
  {
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken(); 
    notificationSystem.startListeningForNewNotification(context);
  }

 

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    initializePushNotificationSystem();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final driverAvailability = Provider.of<DriverAvailability>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: driverAvailability.isDriverAvailable
            ? const Color.fromARGB(255, 1, 76, 62).withOpacity(0.8)
            : const Color.fromARGB(255, 15, 6, 77),
        title: (subscriptionProvider.secondsLeft <= 0)
            ? Padding(
                padding: const EdgeInsets.only(left: 50),
                child: AnimatedTextKit(
                  totalRepeatCount: Duration.secondsPerMinute,
                  animatedTexts: [
                    WavyAnimatedText(
                      'Subscription'.tr(),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                    debugPrint("Tap Event");
                  },
                ),
              )
            : null,
        actions: [
          if (subscriptionProvider.secondsLeft > 0)
            Row(
              children: [
                CupertinoSwitch(
                  value: driverAvailability.isDriverAvailable,
                  onChanged: (value) {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(
                                  0.7,
                                  0.7,
                                ),
                              ),
                            ],
                          ),
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            child: Column(
                              children: [
                                const SizedBox(height: 11),
                                Text(
                                  (!driverAvailability.isDriverAvailable)
                                      ? "GO ONLINE NOW"
                                      : "GO OFFLINE NOW",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 21),
                                Text(
                                  (!driverAvailability.isDriverAvailable)
                                      ? "You are about to go online, you will become available to receive trip requests from users."
                                      : "You are about to go offline, you will stop receiving new trip requests from users.",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white30,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("BACK"),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          driverAvailability
                                              .toggleAvailability();
                                          if (!isDriverAvailable) {
                                            // Go online
                                            goOnlineNow();
                                            // Get driver location updates
                                            setAndGetLocationUpdates();
                                            setState(() {
                                              isDriverAvailable = true;
                                            });
                                          } else {
                                            goOfflineNow();
                                            setState(() {
                                              isDriverAvailable = false;
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: driverAvailability
                                                  .isDriverAvailable
                                              ? Colors.pink
                                              : Colors.green,
                                        ),
                                        child: const Text("CONFIRM"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                // Adjusted width to create space
                Text(
                  driverAvailability.isDriverAvailable ? 'ONLINE' : 'OFFLINE',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          if (subscriptionProvider.subscribed)
            Text(
              ' ${subscriptionProvider.endDate!.toString().substring(0, 10)}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 10),
              child: subscriptionProvider.subscribed
                  ? FlipClock.countdown(
                      width: 20,
                      height: 25,
                      digitColor: Colors.white,
                      backgroundColor:
                          const Color.fromARGB(255, 15, 6, 77).withOpacity(0.1),
                      digitSize: 14.0,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(3.0)),
                      startTime: DateTime(2033, 12, 12),
                      duration:
                          Duration(seconds: subscriptionProvider.secondsLeft),
                    )
                  : const SizedBox(), // Placeholder widget if not subscribed
            ),
          ),
          if (subscriptionProvider.secondsLeft == 0)
            MaterialButtons(
              meterialColor: Colors.amber,
              borderRadius: BorderRadius.circular(5),
              containerheight: 30,
              containerwidth: 110,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Subscription(),
                  ),
                );
              },
              elevationsize: 2,
              text: 'Subscription'.tr(),
              textcolor: Colors.black,
              textweight: FontWeight.bold,
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
             mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;

              googleMapCompleterController.complete(controllerGoogleMap);

                getCurrentLiveLocationOfDriver();
              },
            )
          ],
        ),
      ),
    );
  }
}
