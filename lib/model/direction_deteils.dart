import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionDetails
{
  String? distanceTextString;
  String? durationTextString;
  int? distanceValueDigits;
  int? durationValueDigits;
  
  String? encodedPoints;
  LatLng? startLocation;
  LatLng? endLocation;

  DirectionDetails({
    this.distanceTextString,
    this.durationTextString,
    this.distanceValueDigits,
    this.durationValueDigits,
    this.encodedPoints,
    this.startLocation,
    this.endLocation,
  });
}
