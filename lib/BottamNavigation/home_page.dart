// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kumari_drivers/Subscription/subscription1.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:kumari_drivers/subscription_provider.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();

 
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
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 15, 6, 77),
        
         title:   AnimatedTextKit(

    animatedTexts: [
      WavyAnimatedText('Subscription',textStyle: const TextStyle(color: Colors.white)),
      
    ],
    isRepeatingAnimation: true,
    onTap: () {
      print("Tap Event");
    },
  ),

        actions: [
          if (subscriptionProvider.subscribed)
            Text(
              ' ${subscriptionProvider.endDate!.toString().substring(0, 10)}',
              style: const TextStyle(fontSize: 18,color: Colors.white),
            ),
          const SizedBox(width: 20),
          Text(
            subscriptionProvider.subscribed
                ? _formatDuration(Duration(seconds: subscriptionProvider.secondsLeft))
                : '',
            style: const TextStyle(fontSize: 18,color: Colors.white),
          ),
          if (subscriptionProvider.secondsLeft == 0)
            MaterialButtons(
              meterialColor: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(5),
              
              containerheight: 30,
              containerwidth: 100,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Subscription1()));
              },
              elevationsize: 2,
              text: 'Subscription',
              textcolor: Colors.white,
            ),
          const SizedBox(width: 10),
          
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
