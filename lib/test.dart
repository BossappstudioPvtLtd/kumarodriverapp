import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_clock/flutter_flip_clock.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kumari_drivers/Subscription/subscription.dart';
import 'package:kumari_drivers/Subscription/subscription_data.dart';
import 'package:kumari_drivers/Subscription/subscription_provider.dart';
import 'package:kumari_drivers/Subscription/switch_state.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();

  Position? currentPositionOfUser;
  Color colorToShow = Colors.green;
  String titleToShow = "GO ONLINE NOW";
  bool isDriverAvailable = false;


  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(8.0844, 77.5495),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

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

    // Listen for changes in the SubscriptionProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final subscriptionProvider =
          Provider.of<SubscriptionProvider>(context, listen: false);
      subscriptionProvider.addListener(_subscriptionListener);
      _subscriptionListener(); // Check immediately in case secondsLeft is already 0
    });
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    subscriptionProvider.removeListener(_subscriptionListener);
    super.dispose();
  }

  void _subscriptionListener() {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    final switchState = Provider.of<SwitchState>(context, listen: false);

    if (subscriptionProvider.secondsLeft == 1 && switchState.switchValue) {
      switchState.setSwitchValue(false);
    }
  }

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
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

    final switchState = Provider.of<SwitchState>(context);
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallScreen = screenWidth < 600;


  


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: switchState.switchValue
            ? const Color.fromARGB(255, 1, 76, 62).withOpacity(0.8)
            : const Color.fromARGB(255, 15, 6, 77),
        title: (subscriptionProvider.secondsLeft <= 0)
            ? AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Subscription'.tr(),
                      textStyle: const TextStyle(color: Colors.white)),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  debugPrint("Tap Event");
                },
              )
            : null,
        actions: [
          if (subscriptionProvider.secondsLeft > 0)
            /*CupertinoSwitch(
              value: switchState.switchValue,
              onChanged: (value) {
                switchState.setSwitchValue(value);
              },
              activeColor: Colors.green.shade300,
              trackColor: Colors.white.withOpacity(0.2),
            ),*/
          if (subscriptionProvider.subscribed)
            Text(
              ' ${subscriptionProvider.endDate!.toString().substring(0, 10)}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          /*Text(
            subscriptionProvider.subscribed
                ? _formatDuration(
                    Duration(seconds: subscriptionProvider.secondsLeft))
                : '',
            style: const TextStyle(fontSize: 18, color: Colors.amber),
          ),*/
          const SizedBox(width: 20),
          if (subscriptionProvider.subscribed)
  Padding(
    padding: const EdgeInsets.only(top: 12),
    child: subscriptionProvider.subscribed
        ? FlipClock.countdown(
            width: 20,
            height: 20,
            digitColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 15, 6, 77),
            digitSize: 14.0,
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            startTime: DateTime(2033, 12, 12),
            duration: Duration(seconds: subscriptionProvider.secondsLeft),
          )
        : SizedBox(), // Placeholder widget if not subscribed
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
                /* showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: Material(
                          color: Colors.amber,
                          elevation: 20,
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            height: isSmallScreen ? 250 : 300,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: isSmallScreen ? 40 : 80),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: MaterialButtons(
                                      containerheight: 40,
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        Navigator.pop(context); // Close the popup
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SubscriptionData(),
                                          ),
                                        );
                                      },
                                      text: tr('Add Your Vehicle Details'),
                                      elevationsize: 20,
                                      textcolor: Colors.amber,
                                      textweight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 14 : 16,
                                      meterialColor: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: MaterialButtons(
                                      containerheight: 40,
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        Navigator.pop(context); // Close the popup
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const Subscription(),
                                          ),
                                        );
                                      },
                                      text: tr('Subscription'),
                                      elevationsize: 20,
                                      textcolor: Colors.amber,
                                      textweight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 14 : 16,
                                      meterialColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );*/
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
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Container(
            height: 136,
            width: double.infinity,
            color: Colors.black54,
          ),

          ///go online offline button
          Positioned(
            top: 61,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: ()
                  {
                    showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        builder: (BuildContext context)
                        {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.black87,
                              boxShadow:
                              [
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
                            height: 221,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                              child: Column(
                                children: [

                                  const SizedBox(height:  11,),

                                  Text(
                                      (!isDriverAvailable) ? "GO ONLINE NOW" : "GO OFFLINE NOW",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 21,),

                                  Text(
                                    (!isDriverAvailable)
                                        ? "You are about to go online, you will become available to receive trip requests from users."
                                        : "You are about to go offline, you will stop receiving new trip requests from users.",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white30,
                                    ),
                                  ),

                                  const SizedBox(height: 25,),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: ()
                                          {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "BACK"
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 16,),

                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: ()
                                          {
                                            if(!isDriverAvailable)
                                            {
                                              //go online
                                              //get driver location updates

                                              Navigator.pop(context);

                                              setState(() {
                                                colorToShow = Colors.pink;
                                                titleToShow = "GO OFFLINE NOW";
                                                isDriverAvailable = true;
                                              });
                                            }
                                            else
                                            {
                                              //go offline

                                              Navigator.pop(context);

                                              setState(() {
                                                colorToShow = Colors.green;
                                                titleToShow = "GO ONLINE NOW";
                                                isDriverAvailable = false;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: (titleToShow == "GO ONLINE NOW")
                                                ? Colors.green
                                                : Colors.pink,
                                          ),
                                          child: const Text(
                                              "CONFIRM"
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorToShow,
                  ),
                  child: Text(
                    titleToShow,
                  ),
                ),

              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
