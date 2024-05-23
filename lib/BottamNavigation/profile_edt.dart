// ignore_for_file: unused_element, deprecated_member_use, use_build_context_synchronously, unused_field

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumari_drivers/components/car_seatsedt.dart';
import 'package:kumari_drivers/components/loading_dialog.dart';
import 'package:kumari_drivers/components/material_buttons.dart';

class PrifileEdt extends StatefulWidget {
  const PrifileEdt(
      {super.key, required String name, required String email, required String phone, required String photo});

  @override
  // ignore: library_private_types_in_public_api
  _PrifileEdtState createState() => _PrifileEdtState();
}

class _PrifileEdtState extends State<PrifileEdt> {
  final ImagePicker _picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  File? _image;
  File? _imageFile;
  
  late int _carSeats;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
  TextEditingController phoneNumberTextEditinController =
      TextEditingController();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController vehicleNumberTextEditingController =
      TextEditingController();
  final picker = ImagePicker();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  //updata data
  Future uploadFile() async {
     showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>  LoadingDialog(
          messageText: "Update your Profile",
        ),
      
    );
    if (_image == null) return;
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
 

  await FirebaseDatabase.instance.reference().child('drivers/$userId').update(driverData);
 
 Navigator.pop(context);
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
    _usernameController.text = "";
    _emailController.text = "";
    _phoneController.text = "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
      backgroundColor: Colors.white,
        title: const Text("Profile Editing"),
        surfaceTintColor: Colors.white,
      ),
      body: currentUser == null || userRef == null
        ? const Center(child: Text('No user logged in'))
      :StreamBuilder<Object>(
        stream: userRef!.onValue,
        builder: (context, AsyncSnapshot event) {
           if (event.hasData &&
                  !event.hasError &&
                  event.data.snapshot.value != null){
                      Map data = event.data.snapshot.value;
          return SingleChildScrollView(
            child: Column(
              children: [
               _image == null
                      ? Stack(
                          children: [
                            GestureDetector(
                                onTap: getImage,
                                child: Material(
                                  borderRadius: BorderRadius.circular(40),
                                  elevation: 15,
                                  child:  CircleAvatar(
                                    radius: 43,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage("${data['photo']}")
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
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: const Icon(Icons.add_a_photo_rounded,
                                        size: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Material(
                          elevation: 15,
                          borderRadius: BorderRadius.circular(50),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _image!,
                                height: 80,
                                width: 80,
                              ))),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 30,
                  width: 150,
                  child: Center(child: Text("Add your profile")),
                ),
                
                const SizedBox(
                  height: 50,
                ),
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
                            decoration:  InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                labelText: 'User Name',
                                 hintText: ' ${data['name']}',
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(Icons.person),
                                )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration:  InputDecoration(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(Icons.email),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelText: "User Email",
                              hintText: ' ${data['email']}'
                            ),
                          ),
                        ), 
                       
                        const SizedBox(height: 20),
                        Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            decoration:  InputDecoration(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(Icons.phone_android_rounded),
                              ),
                              labelText: 'Phone Number',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                               hintText: ' ${data['phone']}'
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                         Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            controller: vehicleModelTextEditingController,
                            decoration:  InputDecoration(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(Icons.local_taxi),
                              ),
                              labelText: 'Car Model',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                               hintText: " ${data['car_details']['carModel']}"
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                         Padding(
                           padding: const EdgeInsets.only(right: 20),
                           child: DropDown1(
                                                   onChanged: (value) => _carSeats = value!,
                                                   onSaved: (value) => _carSeats = value!,
                                                 ),
                         ),
                        const SizedBox(height: 20),
                         Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            controller: vehicleNumberTextEditingController,
                            decoration:  InputDecoration(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(Icons.numbers_outlined),
                              ),
                              labelText: 'Car Number',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                               hintText: " ${data['car_details']['carNumber']}"
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
                          text: "Submit",
                          onTap: () {
                           uploadFile();
                          },
                        ),
                        const SizedBox(height: 100,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else{
         return const Center(child: CircularProgressIndicator());
        }
        }
      ),
    );
  }

  
}
