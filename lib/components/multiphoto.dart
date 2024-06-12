import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'dart:io';

import 'package:kumari_drivers/components/material_buttons.dart';

class MultyPhoto extends StatefulWidget {
  const MultyPhoto({Key? key});

  @override
  _MultyPhotoState createState() => _MultyPhotoState();
}

class _MultyPhotoState extends State<MultyPhoto> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;

  void _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        _imageFileList = selectedImages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Pick Images from Gallery'),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmallScreen ? 2 : 3, // Adjust crossAxisCount based on screen size
                ),
                itemCount: _imageFileList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(File(_imageFileList![index].path));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                child: IconButton(
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black87,
                          elevation: 20,
                          title: TextEdt(
                            text: 'Email Sign Out'.tr(),
                            color: Colors.white, fontSize: 24,
                          ),
                          content: TextEdt(
                            text:
                                'Do you want to continue with sign out?'.tr(),
                            color: Colors.grey, fontSize: 24,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButtons(
                                  onTap: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  elevationsize: 20,
                                  text: '   Cancel    '.tr(),
                                  fontSize: 17,
                                  containerheight: 40,
                                  containerwidth: 100,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  onPressed: null,
                                ),
                                MaterialButtons(
                                  onTap: () {
                                    _signOut();
                                    Navigator.of(context).pop();
                                  },
                                  elevationsize: 20,
                                  text: 'Continue'.tr(),
                                  fontSize: 17,
                                  containerheight: 40,
                                  containerwidth: 100,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  onPressed: null,
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.power_settings_new,
                  ),
                  color: Colors.red,
                  iconSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
