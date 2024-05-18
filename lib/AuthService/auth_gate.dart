
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/BottamNavigation/dashbord.dart';
import 'package:kumari_drivers/AuthanticationPages/login.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return   const Dashboard();
          } else {
            return const LoginScreen ();
          }
        },
      ),
    );
  }
}
