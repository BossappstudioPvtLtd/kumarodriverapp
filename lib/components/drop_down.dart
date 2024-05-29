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
// Initial Selected Value
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                    width:55.0,
                    padding: const EdgeInsets.all(17.0),
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
                    )),
              ),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 1),
               child: Container(
                  height: 57,
                  width: 264,
                  color: Colors.black,
                  
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.black87,
                          items:  const [
                            DropdownMenuItem(
                                value: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    '3 seats',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            DropdownMenuItem(
                                value: 4,
                                child: Text(
                                  '4 seats',
                                  style: TextStyle(color: Colors.white),
                                )),
                            DropdownMenuItem(
                                value: 7,
                                child: Text(
                                  '7 seats',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                          onChanged: widget.onChanged,
                          onSaved: widget.onChanged,
                          decoration:  const InputDecoration(
                              labelText: 'Car Seats',
                              labelStyle: TextStyle(color: Colors.white70)),
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
