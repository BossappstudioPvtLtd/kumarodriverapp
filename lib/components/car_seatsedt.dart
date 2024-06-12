import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DropDown1 extends StatefulWidget {
  final int initialValue;
  final void Function(int?)? onChanged;
  final void Function(dynamic value) onSaved;

  const DropDown1({
    super.key,
    required this.initialValue,
    this.onChanged,
    required this.onSaved,
  });

  @override
  DropDown1State createState() => DropDown1State();
}

class DropDown1State extends State<DropDown1> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600;

    return Column(
      children: [
        Row(
          children: [
            Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(32),
              child: Container(
                height: 57,
                width: isSmallScreen ? screenWidth * 0.9 : 323,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField<int>(
                    borderRadius: BorderRadius.circular(16),
                    dropdownColor: Colors.white,
                    value: _selectedValue,
                    items: const [
                      DropdownMenuItem(
                          value: 3,
                          child: Text(
                            '3 seats',
                            style: TextStyle(color: Colors.black),
                          )),
                      DropdownMenuItem(
                          value: 4,
                          child: Text(
                            '4 seats',
                            style: TextStyle(color: Colors.black),
                          )),
                      DropdownMenuItem(
                          value: 7,
                          child: Text(
                            '7 seats',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(newValue);
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.airline_seat_recline_normal_rounded,
                        size: isSmallScreen ? 20 : 24,
                      ),
                      labelText: 'Car Seats'.tr(),
                      labelStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
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
