import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";



String googleMapKey = "AIzaSyCH-K_JDF4Sfaa2EL7MKeD0PQ0jPfIQv98";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(8.088306,  77.538452),
  zoom: 14.4746,
);


StreamSubscription<Position>? positionStreamHomePage;

String driverName = "";
String driverPhone = "";
String driverPhoto = "";
String carColor = "";
String carModel = "";
String carNumber = "";
