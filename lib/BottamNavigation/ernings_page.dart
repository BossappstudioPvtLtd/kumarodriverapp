import 'package:flutter/material.dart';
import 'package:flutter_flip_clock/flutter_flip_clock.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:Colors.white,
     
        body: Center(
          child: Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(17),
                        topLeft: Radius.circular(17)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 17,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      )
                    ]),
                height: 256,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //trip duration
                      const Center(
                        child: Text(
                          "25",
                          //  durationText + " - " + distanceText,
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
          
                      //user name - call user icon btn
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //user name
          
                          const Text(
                            "widget.newTripDetailsInfo!.userName!,",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
          
                          //call user icon btn
                          InkWell(
                            onTap: () {
                             // launchUrl(
                             //   Uri.parse(
                             //       "tel://${widget.newTripDetailsInfo!.userPhone.toString()}"),
                             // );
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.phone_android_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
          
                      //pickup icon and location
          
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/initial.png",
                            height: 16,
                            width: 16,
                          ),
                          const Expanded(
                            child: Text(
                              "widget.newTripDetailsInfo!.pickupAddress.toString(),",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
          
                      //dropoff icon and location
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/initial.png",
                            height: 16,
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              "widget.newTripDetailsInfo!.dropOffAddress"
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
          
                      const SizedBox(
                        height: 25,
                      ),
          
                      
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
