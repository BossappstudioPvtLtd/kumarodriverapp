import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kumari_drivers/onBoding.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: 'AIzaSyBevn7kkdLhblWAVvG6lhLYoDk7C12LPKA',
      appId: '1:1028914323103:android:b2429b3396633ec037ccaa',
      messagingSenderId: '1028914323103',
      projectId: 'bossapp-9fba7',
      authDomain: 'bossapp-9fba7.firebaseapp.com',
      storageBucket: 'bossapp-9fba7.appspot.com',
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoding(),
    );
  }
}


