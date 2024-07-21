// ignore_for_file: override_on_non_overriding_member, use_build_context_synchronously, body_might_complete_normally_catch_error, unrelated_type_equality_checks
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumari_drivers/components/my_Textfield.dart';
import 'package:kumari_drivers/BottamNavigation/dashbord.dart';
import 'package:kumari_drivers/components/drop_down.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Methords/common_methords.dart';
import '../Dialog/loading_dialog.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool passwordVisible = false;
  late int _carSeats;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditinController =
      TextEditingController();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController vehicleNumberTextEditingController =
      TextEditingController();
  CommonMethods cMethods = CommonMethods();
  XFile? imageFile;
  String urlOfUploadedImage = "";

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);

    if (imageFile != null) {
      signUpFormValidation();
    } else {
      cMethods.displaySnackBar("Please choose an image first.", context);
    }
  }

  signUpFormValidation() {
    if (userNameTextEditingController.text.trim().length < 4) {
      cMethods.displaySnackBar(
          "Your name must be at least 4 or more characters.", context);
    } else if (!emailTextEditingController.text.contains("@")) {
      cMethods.displaySnackBar("Please write a valid email.", context);
    } else if (passwordTextEditingController.text.trim().length < 6) {
      cMethods.displaySnackBar(
          "Your password must be at least 6 or more characters.", context);
    } else if (phoneNumberTextEditinController.text.trim().length < 10) {
      cMethods.displaySnackBar(
          "Your phone number must be at least 10 or more characters.", context);
    } else if (vehicleModelTextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("Please write your vehicle model.", context);
    } else if (vehicleNumberTextEditingController.text.isEmpty) {
      cMethods.displaySnackBar("Please write your vehicle number.", context);
    } else {
      uploadImageToStorage();
    }
  }

  uploadImageToStorage() async {
    String imageIDName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceImage =
        FirebaseStorage.instance.ref().child("Images").child(imageIDName);
    UploadTask uploadTask = referenceImage.putFile(File(imageFile!.path));
    TaskSnapshot snapshot = await uploadTask;
    urlOfUploadedImage = await snapshot.ref.getDownloadURL();

    setState(() {
      urlOfUploadedImage;
    });

    registerNewDriver();
  }

  registerNewDriver() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(
        messageText: "Registering account",
      ),
    );

    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    ).catchError((errorMsg) {
      Navigator.pop(context);
      cMethods.displaySnackBar(errorMsg.toString(), context);
    }))
        .user;

    if (!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(userFirebase!.uid);

    Map driverCarInfo = {
      "carModel": vehicleModelTextEditingController.text.trim(),
      'carSeats': _carSeats,
      "carNumber": vehicleNumberTextEditingController.text.trim(),
    };

    Map driverDataMap = {
      "photo": urlOfUploadedImage,
      "car_details": driverCarInfo,
      "name": userNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": phoneNumberTextEditinController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    usersRef.set(driverDataMap);

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const Dashboard()));
  }

  chooseImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isSmallScreen = screenWidth < 600;

    double imageRadius = isSmallScreen ? screenWidth * 0.2 : screenWidth * 0.15;
    double spacing = screenHeight * 0.02;

    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                SizedBox(height: spacing),
                imageFile == null
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/user.jpg",),
                      )
                    : Container(
                        width: imageRadius * 2,
                        height: imageRadius * 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(imageFile!.path)),
                          ),
                        ),
                      ),
                SizedBox(height: spacing),
                GestureDetector(
                  onTap: chooseImageFromGallery,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: spacing),
                MyTextField(
                  controller: userNameTextEditingController,
                  materialcolor: const Color(0xffA9DED8),
                  textstylecolor: const TextStyle(color: Color(0xffA9DED8)),
                  fillColor: Colors.black,
                  labelText: "Your Name",
                  labelStylecolor: const TextStyle(color: Colors.white70),
                  icon: Icons.person_2_outlined,
                  iconcolor: Colors.black,
                  obscureText: false,
                ),
                SizedBox(height: spacing),
                MyTextField(
                  controller: emailTextEditingController,
                  materialcolor: const Color(0xffA9DED8),
                  textstylecolor: const TextStyle(color: Color(0xffA9DED8)),
                  fillColor: Colors.black,
                  labelText: "Your Email",
                  labelStylecolor: const TextStyle(color: Colors.white70),
                  icon: Icons.email_outlined,
                  iconcolor: Colors.black,
                  obscureText: false,
                ),
                SizedBox(height: spacing),
                MyTextField(
                  controller: passwordTextEditingController,
                  materialcolor: const Color(0xffA9DED8),
                  textstylecolor: const TextStyle(color: Color(0xffA9DED8)),
                  fillColor: Colors.black,
                  labelText: "Your Password",
                  labelStylecolor: const TextStyle(color: Colors.white70),
                  icon: Icons.lock_outline_sharp,
                  iconcolor: Colors.black,
                  obscureText: passwordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: spacing),
                MyTextField(
                  controller: phoneNumberTextEditinController,
                  keyboardType: TextInputType.phone,
                  materialcolor: const Color(0xffA9DED8),
                  textstylecolor: const TextStyle(color: Color(0xffA9DED8)),
                  fillColor: Colors.black,
                  labelText: "Phone Number",
                  labelStylecolor: const TextStyle(color: Colors.white70),
                  icon: Icons.smartphone_sharp,
                  iconcolor: Colors.black,
                  obscureText: false,
                ),
                SizedBox(height: spacing),
                MyTextField(
                  controller: vehicleModelTextEditingController,
                  materialcolor: const Color(0xffA9DED8),
                  textstylecolor: const TextStyle(color: Color(0xffA9DED8)),
                  fillColor: Colors.black,
                  labelText: "Vehicle Model",
                  labelStylecolor: const TextStyle(color: Colors.white70),
                  icon: Icons.local_taxi,
                  iconcolor: Colors.black,
                  obscureText: false,
                ),
                SizedBox(height: spacing),
                DropDown(
                  onChanged: (value) => _carSeats = value!,
                  onSaved: (value) => _carSeats = value!,
                ),
                SizedBox(height: spacing),
                MyTextField(
                  controller: vehicleNumberTextEditingController,
                  materialcolor: const Color(0xffA9DED8),
                  textstylecolor: const TextStyle(color: Color(0xffA9DED8)),
                  fillColor: Colors.black,
                  labelText: "Vehicle Number",
                  labelStylecolor: const TextStyle(color: Colors.white70),
                  icon: Icons.numbers_outlined,
                  iconcolor: Colors.black,
                  obscureText: false,
                ),
                SizedBox(height: spacing),
                RichText(
                  text: TextSpan(
                    text: 'Already have an Account? Login Here',
                    style: const TextStyle(color: Colors.white70),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        HapticFeedback.lightImpact();
                        Fluttertoast.showToast(
                          msg: 'Already have an account',
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: screenWidth * .03),
                          height: screenWidth * .3,
                          width: screenWidth * .3,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Color(0xff09090A),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Transform.scale(
                          scale: _animation.value,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              checkIfNetworkIsAvailable();
                              HapticFeedback.lightImpact();
                              Fluttertoast.showToast(
                                msg: 'Register',
                              );
                            },
                            child: Container(
                              height: screenWidth * .2,
                              width: screenWidth * .2,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color(0xffA9DED8),
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
