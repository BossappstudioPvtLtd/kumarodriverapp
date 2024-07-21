import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumari_drivers/components/car_seatsedt.dart';
import 'package:kumari_drivers/Dialog/loading_dialog.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:nb_utils/nb_utils.dart';

class PrifileEdt extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String carModel;
  final String carSeats;
  final String carNumber;

  const PrifileEdt({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.carModel,
    required this.carSeats,
    required this.carNumber,
  });

  @override
  _PrifileEdtState createState() => _PrifileEdtState();
}

class _PrifileEdtState extends State<PrifileEdt> {
  final ImagePicker _picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  File? _image;
  late int _carSeats;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController vehicleNumberTextEditingController =
      TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers and set their initial values
    _usernameController.text = widget.name;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    vehicleModelTextEditingController.text = widget.carModel;
    vehicleNumberTextEditingController.text =
        widget.carNumber; // Set initial car number
    _carSeats = int.tryParse(widget.carSeats) ?? 3; // Initialize _carSeats
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    vehicleModelTextEditingController.dispose();
    vehicleNumberTextEditingController.dispose();
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(
        messageText: "Updating Profile",
      ),
    );

    if (_image == null) {
      // No new image selected, just update the user data with the existing photo URL
      updateUserData(widget.photo);
    } else {
      // New image selected, upload it and then update the user data
      String userId = _auth.currentUser!.uid;
      String fileName = 'user_photos/$userId';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(_image!);
      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        updateUserData(downloadURL);
      });
    }
  }

  Future<void> updateUserData(String photoUrl) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> driverData = {
      'name': _usernameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'photo': photoUrl,
      'car_details': {
        'carModel': vehicleModelTextEditingController.text.trim(),
        'carNumber': vehicleNumberTextEditingController.text.trim(),
        'carSeats': _carSeats,
      },
    };

    await FirebaseDatabase.instance
        .reference()
        .child('drivers/$userId')
        .update(driverData);

    Navigator.pop(context);
    // Optionally, you can show a success message or navigate to another screen here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile Editing".tr()),
        surfaceTintColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 600;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: getImage,
                          child: Material(
                            borderRadius: BorderRadius.circular(40),
                            elevation: 15,
                            child: CircleAvatar(
                              radius: 43,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: _image != null
                                    ? FileImage(_image!) as ImageProvider
                                    : NetworkImage(widget.photo) as ImageProvider,
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 60, left: 60),
                        child: InkWell(
                          onTap: getImage,
                          child: Material(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(235, 1, 72, 130),
                            child: const SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.add_a_photo_rounded,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                   20.height,
                  SizedBox(
                    child: Center(child: Text("Add your profile".tr())),
                  ),
                   20.height,
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'User Name'.tr(),
                                icon: Padding(
                                  padding: EdgeInsets.only(left: isSmallScreen ? 8 : 15),
                                  child: Icon(Icons.person, size: isSmallScreen ? 20 : 24),
                                ),
                              ),
                            ),
                          ),
                           20.height,
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                icon: Padding(
                                  padding: EdgeInsets.only(left: isSmallScreen ? 8 : 15),
                                  child: Icon(Icons.email, size: isSmallScreen ? 20 : 24),
                                ),
                                border: InputBorder.none,
                                labelText: "User Email".tr(),
                              ),
                            ),
                          ),
                           20.height,
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                icon: Padding(
                                  padding: EdgeInsets.only(left: isSmallScreen ? 8 : 15),
                                  child: Icon(Icons.phone_android_rounded, size: isSmallScreen ? 20 : 24),
                                ),
                                labelText: 'Phone Number'.tr(),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          20.height,
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              controller: vehicleModelTextEditingController,
                              decoration: InputDecoration(
                                icon: Padding(
                                  padding: EdgeInsets.only(left: isSmallScreen ? 8 : 15),
                                  child: Icon(Icons.local_taxi, size: isSmallScreen ? 20 : 24),
                                ),
                                labelText: 'Car Model'.tr(),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropDown1(
                            initialValue: _carSeats,
                            onChanged: (value) {
                              setState(() {
                                _carSeats = value!;
                              });
                            },
                            onSaved: (value) {},
                          ),
                          const SizedBox(height: 20),
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              controller: vehicleNumberTextEditingController,
                              decoration: InputDecoration(
                                icon: Padding(
                                  padding: EdgeInsets.only(left: isSmallScreen ? 8 : 15),
                                  child: Icon(Icons.numbers_outlined, size: isSmallScreen ? 20 : 24),
                                ),
                                labelText: 'Car Number'.tr(),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          MaterialButtons(
                            borderRadius: BorderRadius.circular(10),
                            meterialColor: const Color.fromARGB(255, 3, 22, 60),
                            containerheight: 50,
                            elevationsize: 20,
                            textcolor: Colors.white,
                            fontSize: 18,
                            textweight: FontWeight.bold,
                            text: "Submit".tr(),
                            onTap: () {
                              uploadFile();
                            },
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
