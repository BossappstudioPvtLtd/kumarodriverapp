import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kumari_drivers/Subscription/driver_avl.dart';
import 'package:kumari_drivers/Subscription/switch_state.dart';
import 'package:kumari_drivers/onBoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:kumari_drivers/Subscription/subscription_provider.dart'; // Make sure to import your provider
// Import SwitchState

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCH-K_JDF4Sfaa2EL7MKeD0PQ0jPfIQv98',
      appId: '1:1028914323103:android:b2429b3396633ec037ccaa',
      messagingSenderId: '1028914323103',
      projectId: 'bossapp-9fba7',
      authDomain: 'bossapp-9fba7.firebaseapp.com',
      storageBucket: 'bossapp-9fba7.appspot.com',
    ),
    
  );
  await Permission.notification.isDenied.then((valueofPermission)
  {
    if(valueofPermission)
    {
      Permission.notification.request();
    }
  });

   await Permission.notification.isDenied.then((valueOfPermission)
  {
    if(valueOfPermission)
    {
      Permission.notification.request();
    }
  });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => SwitchState()), // Provide SwitchState
         ChangeNotifierProvider(create: (_) => DriverAvailability()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ta', 'IN'),
          Locale('ml', 'IN'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Drivers App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const  OnBoding(), // Set HomePage as the home
    );
  }
}
