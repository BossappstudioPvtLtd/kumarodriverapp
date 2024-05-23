// ignore_for_file: camel_case_types, library_private_types_in_public_api, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropDown1 extends StatefulWidget {
  final void Function(int?)? onChanged;
  final void Function(int?)? onSaved;
  const DropDown1({super.key, this.onChanged, this.onSaved});

  @override
  DropDown1State createState() => DropDown1State();
}

class DropDown1State extends State<DropDown1> {
// Initial Selected Value
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 57,
                width: 320,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 8,
                      dropdownColor: Colors.grey[300],
                      items: const [
                        DropdownMenuItem(
                            value: 3,
                            child: Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                '  3 seats',
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        DropdownMenuItem(
                            value: 4,
                            child: Text(
                              '  4 seats',
                              style: TextStyle(color: Colors.black),
                            )),
                        DropdownMenuItem(
                            value: 7,
                            child: Text(
                              '  7 seats',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                      onChanged: widget.onChanged,
                      onSaved: widget.onChanged,
                      decoration: const InputDecoration(
                        
                       icon:  Icon(Icons.airline_seat_recline_normal_rounded),
                      
                          enabled: false,
                          labelText:'Car Seats',
                          labelStyle: TextStyle(color: Colors.black)),
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
