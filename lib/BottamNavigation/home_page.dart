import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_clock/flutter_flip_clock.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kumari_drivers/AuthanticationPages/login.dart';
import 'package:kumari_drivers/Subscription/driver_avl.dart';
import 'package:kumari_drivers/Subscription/subscription.dart';
import 'package:kumari_drivers/Subscription/subscription_provider.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller = Completer();
  Position? currentPositionOfUser;
  Color colorToShow = Colors.green;
  String titleToShow = "GO ONLINE NOW";
  String userName = "";

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(8.0844, 77.5495),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getUserInfoAndCheckBlockStatus();
    initializeGeoFireListener();
    getUserCurrentLocation().then((value) async {
      debugPrint("${value.latitude} ${value.longitude}");

      // marker added for current users location
      _markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
      ));

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
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
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You are blocked. Contact admin: Kumariacabs@gmail.com")));
      }
    } else {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const LoginScreen()));
    }
  }

  void initializeGeoFireListener() {
    // Your logic for GeoFire listener goes here
  }

  void checkSubscriptionTimer() {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    final driverAvailability =
        Provider.of<DriverAvailability>(context, listen: false);

    // If subscription timer countdown is zero, set driver's availability to offline
    if (subscriptionProvider.secondsLeft == 0 &&
        driverAvailability.isDriverAvailable) {
      driverAvailability.toggleAvailability();
    }
  }

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      infoWindow: InfoWindow(
        title: 'My Position',
      ),
    ),
  ];

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }


  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final driverAvailability = Provider.of<DriverAvailability>(context);

    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallScreen = screenWidth < 600;

    // Check if subscription timer countdown is 0 and toggle availability
    if (subscriptionProvider.secondsLeft == 0 &&
        driverAvailability.isDriverAvailable) {
      driverAvailability.toggleAvailability();
    }

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
                  : SizedBox(), // Placeholder widget if not subscribed
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
              initialCameraPosition: _kGoogle,
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ],
        ),
      ),
    );
  }
}
