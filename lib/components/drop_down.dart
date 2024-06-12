// ignore_for_file: camel_case_types, library_private_types_in_public_api, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropDown extends StatefulWidget {
  final void Function(int?)? onChanged;
  final void Function(int?)? onSaved;
  const DropDown({super.key, this.onChanged, this.onSaved});

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate dynamic sizes based on screen width
    double iconContainerWidth = screenWidth * 0.15;
    double dropDownWidth = screenWidth * 0.65;
    double containerHeight = screenWidth * 0.15;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  width: iconContainerWidth,
                  height: containerHeight,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Color(0xffA9DED8),
                  ),
                  child: const Icon(
                    Icons.airline_seat_recline_normal_rounded,
                    size: 25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Container(
                height: containerHeight,
                width: dropDownWidth*1.22,
                color: Colors.black,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.02),
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.black87,
                      items: const [
                        DropdownMenuItem(
                          value: 3,
                          child: Text(
                            '3 seats',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text(
                            '4 seats',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 7,
                          child: Text(
                            '7 seats',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                      onChanged: widget.onChanged,
                      onSaved: widget.onSaved,
                      decoration: const InputDecoration(
                        labelText: 'Car Seats',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
