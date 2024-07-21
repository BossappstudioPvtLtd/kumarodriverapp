// ignore_for_file: unused_element, deprecated_member_use, use_build_context_synchronously, unused_field

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:kumari_drivers/components/car_seatsedt.dart';
import 'package:kumari_drivers/Dialog/loading_dialog.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:nb_utils/nb_utils.dart';

class SubscriptionData extends StatefulWidget {
  const SubscriptionData({super.key});

  @override
  _SubscriptionDataState createState() => _SubscriptionDataState();
}

class _SubscriptionDataState extends State<SubscriptionData> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final ImagePicker _picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  File? _profileImage;
  File? _carImage;
  File? _licenseImage;
  File? _insuranceImage;
  File? _rcBookImage;

  late int _carSeats;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _insuranceExpiryDateController =
      TextEditingController();
  final TextEditingController _licenseExpiryDateController =
      TextEditingController();
  final TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  final TextEditingController vehicleNumberTextEditingController =
      TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final picker = ImagePicker();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenseNumberController.dispose();
    _insuranceExpiryDateController.dispose();
    _licenseExpiryDateController.dispose();
    vehicleModelTextEditingController.dispose();
    vehicleNumberTextEditingController.dispose();
    super.dispose();
  }

  Future getImage(ImageSource source, Function(File?) setImage) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        setImage(File(pickedFile.path));
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
        messageText: "Updating your profile",
      ),
    );

    if (_profileImage == null ||
        _carImage == null ||
        _licenseImage == null ||
        _insuranceImage == null ||
        _rcBookImage == null) {
      // Show a snackbar or alert dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select all required images.'),
        ),
      );
      return;
    }

    Map<String, String> uploadedUrls = {};
    for (var image in [
      {'image': _profileImage, 'type': 'profile_photo'},
      {'image': _carImage, 'type': 'car_photo'},
      {'image': _licenseImage, 'type': 'license_photo'},
      {'image': _insuranceImage, 'type': 'insurance_photo'},
      {'image': _rcBookImage, 'type': 'rc_book_photo'}
    ]) {
      if (image['image'] != null) {
        String userId = _auth.currentUser!.uid;
        String fileName = '${image['type']}/$userId';
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child(fileName);
        UploadTask uploadTask = ref.putFile(image['image']! as File);
        await uploadTask.whenComplete(() async {
          String downloadURL = await ref.getDownloadURL();
          uploadedUrls[image['type'] as String] = downloadURL;
        });
      }
    }

    updateUserData(uploadedUrls);
  }

  Future<void> updateUserData(Map<String, String> urls) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> driverData = {
      'name': _usernameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'photo': urls['profile_photo'],
      'car_details': {
        'carModel': vehicleModelTextEditingController.text.trim(),
        'carNumber': vehicleNumberTextEditingController.text.trim(),
        'carSeats': _carSeats,
        'carPhoto': urls['car_photo']
      },
      'license_details': {
        'licenseNumber': _licenseNumberController.text.trim(),
        'licenseExpiryDate': _licenseExpiryDateController.text.trim(),
        'licensePhoto': urls['license_photo'],
      },
      'insurance_details': {
        'insuranceExpiryDate': _insuranceExpiryDateController.text.trim(),
        'insurancePhoto': urls['insurance_photo']
      },
      'rc_book_details': {'rcBookPhoto': urls['rc_book_photo']}
    };

    await FirebaseDatabase.instance
        .reference()
        .child('drivers/$userId')
        .update(driverData);

    Navigator.pop(context);
  }

  Future<void> createUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> driverData = {
      'name': _usernameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'photo': null,
      'car_details': {
        'carModel': vehicleModelTextEditingController.text.trim(),
        'carNumber': vehicleNumberTextEditingController.text.trim(),
        'carSeats': _carSeats,
        'carPhoto': null
      },
      'license_details': {
        'licenseNumber': _licenseNumberController.text.trim(),
        'licenseExpiryDate': _licenseExpiryDateController.text.trim(),
        'licensePhoto': null,
      },
      'insurance_details': {
        'insuranceExpiryDate': _insuranceExpiryDateController.text.trim(),
        'insurancePhoto': null
      },
      'rc_book_details': {'rcBookPhoto': null}
    };

    await FirebaseDatabase.instance
        .reference()
        .child('drivers/$userId')
        .set(driverData);
  }

  Future<void> deleteUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseDatabase.instance
        .reference()
        .child('drivers/$userId')
        .remove();
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference? userRef;

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      userRef = FirebaseDatabase.instance
          .reference()
          .child('drivers/${currentUser!.uid}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Subscription".tr(),
          style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: currentUser == null || userRef == null
          ? const Center(child: Text('No user logged in'))
          : StreamBuilder(
              stream: userRef!.onValue,
              builder: (context, AsyncSnapshot event) {
                if (event.hasData &&
                    !event.hasError &&
                    event.data.snapshot.value != null) {
                  Map data = event.data.snapshot.value;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "Profile Details".tr(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          40.height,
                          buildImagePicker(context, _profileImage,
                              data['photo'], (file) => _profileImage = file),
                          const SizedBox(height: 20),
                          buildForm(context, data),
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
                              if (_formKey.currentState!.validate()) {
                                uploadFile();
                              }
                            },
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }

  Widget buildImagePicker(BuildContext context, File? imageFile,
      String imageUrl, Function(File?) setImage) {
    return imageFile == null
        ? Stack(
            children: [
              GestureDetector(
                  onTap: () => getImage(ImageSource.gallery, setImage),
                  child: Material(
                    borderRadius: BorderRadius.circular(40),
                    elevation: 15,
                    child: imageUrl.isNotEmpty
                        ? CircleAvatar(
                            radius: 43,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(imageUrl)),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: const Placeholder(
                              strokeWidth: 0,
                              fallbackHeight: BorderSide.strokeAlignCenter,
                            )),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 60),
                child: InkWell(
                  onTap: () => getImage(ImageSource.gallery, setImage),
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
              ),
            ],
          )
        : Material(
            elevation: 15,
            borderRadius: BorderRadius.circular(30),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  imageFile,
                  height: 100,
                  width: 100,
                )),
          );
  }

  Widget buildForm(BuildContext context, Map data) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildSubheading("User Information".tr()),
            buildTextFormField(
                _usernameController, 'User Name', data['name'], Icons.person),
            const SizedBox(height: 20),
            buildTextFormField(
                _emailController, 'User Email', data['email'], Icons.email),
            const SizedBox(height: 20),
            buildTextFormField(_phoneController, 'Phone Number', data['phone'],
                Icons.phone_android_rounded,
                keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            buildSubheading("License Details"),
            buildTextFormField(_licenseNumberController,
                'Driving License Number', '', Icons.card_membership),
            const SizedBox(height: 20),
            buildTextFormField(_licenseExpiryDateController,
                'License Expiry Date', '', Icons.date_range,
                keyboardType: TextInputType.datetime),
            const SizedBox(height: 20),
            buildImagePicker(
                context,
                _licenseImage,
                data['license_details']?['licensePhoto'] ?? '',
                (file) => _licenseImage = file),
            const SizedBox(height: 50),
            buildSubheading("Car Details"),
            buildTextFormField(vehicleModelTextEditingController, 'Car Model',
                data['car_details']?['carModel'] ?? '', Icons.local_taxi),
            const SizedBox(height: 20),
           /* DropDown1(
              onChanged: (value) => _carSeats = value!,
              onSaved: (value) => _carSeats = value!, initialValue: _carSeats,
            ),*/
            
            const SizedBox(height: 20),
            buildTextFormField(
                vehicleNumberTextEditingController,
                'Car Number',
                data['car_details']?['carNumber'] ?? '',
                Icons.numbers_outlined),
            const SizedBox(height: 20),
            buildImagePicker(
                context,
                _carImage,
                data['car_details']?['carPhoto'] ?? '',
                (file) => _carImage = file),
            const SizedBox(height: 20),
            buildTextFormField(_insuranceExpiryDateController,
                'Insurance Expiry Date', '', Icons.date_range,
                keyboardType: TextInputType.datetime),
            const SizedBox(height: 20),
            buildImagePicker(
                context,
                _insuranceImage,
                data['insurance_details']?['insurancePhoto'] ?? '',
                (file) => _insuranceImage = file),
            const SizedBox(height: 20),
            buildSubheading("RC Book Details"),
            buildImagePicker(
                context,
                _rcBookImage,
                data['rc_book_details']?['rcBookPhoto'] ?? '',
                (file) => _rcBookImage = file),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String label,
      String hintText, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(icon),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: label.tr(),
            hintText: hintText),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget buildSubheading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text.tr(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}
