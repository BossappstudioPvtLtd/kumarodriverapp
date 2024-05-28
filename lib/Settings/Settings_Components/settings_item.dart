import 'package:flutter/material.dart';

class SettingItem extends StatefulWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;
  final Widget? child;
  const SettingItem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.value, this.child,
  });

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topRight: Radius.circular(15)),
      elevation: 20,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.bgColor,
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                ),
              ),
            ),
             SizedBox(width: 20),
            Text(
              widget.title,
              style:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
             Spacer(),
            widget.value != null
                ? Text(
                    widget.value!,
                    style:  TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                :  SizedBox(),
             SizedBox(width: 20),
            Container(
              child:widget.child
            )
          ],
        ),
      ),
    );
  }
}
