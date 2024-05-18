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

import '../Methords/common_methords.dart';
import '../components/loading_dialog.dart';
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
  // TextEditingController confirmPasswordTextEditinController =
  // TextEditingController();
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

    if (imageFile != null) //image validation
    {
      signUpFormValidation();
    } else {
      cMethods.displaySnackBar("Please choose image first.", context);
    }
  }

  signUpFormValidation() {
    if (userNameTextEditingController.text.trim().length < 4) {
      cMethods.displaySnackBar(
          "your name must be atleast 4 or more characters.", context);
    } else if (!emailTextEditingController.text.contains("@")) {
      cMethods.displaySnackBar("please write valid email.", context);
    } else if (passwordTextEditingController.text.trim().length < 6) {
      cMethods.displaySnackBar(
          "your password must be atleast 6 or more characters.", context);
    } 
    else if (phoneNumberTextEditinController.text.trim().length < 10) {
      cMethods.displaySnackBar(
          "your phone number must be atleast 10 or more characters.", context);
    } else if (vehicleModelTextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("please write your vehicale model", context);
    } else if (vehicleNumberTextEditingController.text.isEmpty) {
      cMethods.displaySnackBar("please write your vehicale number.", context);
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
      builder: (BuildContext context) =>  LoadingDialog(
          messageText: "Registering  account",
        ),
      
    );

    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((errorMsg) {
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
      "careModel": vehicleModelTextEditingController.text.trim(),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 25,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      imageFile == null
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/images/user.jpg"),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: FileImage(
                                        File(
                                          imageFile!.path,
                                        ),
                                        
                                      ))),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          chooseImageFromGallery();
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: userNameTextEditingController,
                        materialcolor: const Color(0xffA9DED8),
                        textstylecolor: const TextStyle(
                          color: Color(0xffA9DED8),
                        ),
                        fillColor: Colors.black,
                        labelText: "Your Name",
                        labelStylecolor: const TextStyle(color: Colors.white70),
                        icon: Icons.person_2_outlined,
                        iconcolor: Colors.black,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: emailTextEditingController,
                        materialcolor: const Color(0xffA9DED8),
                        textstylecolor: const TextStyle(
                          color: Color(0xffA9DED8),
                        ),
                        fillColor: Colors.black,
                        labelText: "Your Email",
                        labelStylecolor: const TextStyle(color: Colors.white70),
                        icon: Icons.email_outlined,
                        iconcolor: Colors.black,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: passwordTextEditingController,
                        materialcolor: const Color(0xffA9DED8),
                        textstylecolor: const TextStyle(
                          color: Color(0xffA9DED8),
                        ),
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
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: phoneNumberTextEditinController,
                        keyboardType: TextInputType.phone,
                        materialcolor: const Color(0xffA9DED8),
                        textstylecolor: const TextStyle(
                          color: Color(0xffA9DED8),
                        ),
                        fillColor: Colors.black,
                        labelText: "Phone Number",
                        labelStylecolor: const TextStyle(color: Colors.white70),
                        icon: Icons.smartphone_sharp,
                        iconcolor: Colors.black,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: vehicleModelTextEditingController,
                        materialcolor: const Color(0xffA9DED8),
                        textstylecolor: const TextStyle(
                          color: Color(0xffA9DED8),
                        ),
                        fillColor: Colors.black,
                        labelText: "Vehicle Model",
                        labelStylecolor: const TextStyle(color: Colors.white70),
                        icon: Icons.local_taxi,
                        iconcolor: Colors.black,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DropDown(
                        onChanged: (value) => _carSeats = value!,
                        onSaved: (value) => _carSeats = value!,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: vehicleNumberTextEditingController,
                        materialcolor: const Color(0xffA9DED8),
                        textstylecolor: const TextStyle(
                          color: Color(0xffA9DED8),
                        ),
                        fillColor: Colors.black,
                        labelText: "Vehicle Number",
                        labelStylecolor: const TextStyle(color: Colors.white70),
                        icon: Icons.numbers_outlined,
                        iconcolor: Colors.black,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Already have an Account? Login Here',
                              style: const TextStyle(color: Colors.white70),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                    msg: 'Already have an account ',
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
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: width * .03),
                                height: width * .3,
                                width: width * .3,
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
                                      msg: 'Register ',
                                    );
                                  },
                                  child: Container(
                                    height: width * .2,
                                    width: width * .2,
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
