import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/AuthanticationPages/login.dart';
import 'package:kumari_drivers/BottamNavigation/ernings_page.dart';
import 'package:kumari_drivers/BottamNavigation/home_page.dart';
import 'package:kumari_drivers/BottamNavigation/profile_page.dart';
import 'package:kumari_drivers/BottamNavigation/trips_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? controller;
  int indexSelected = 0;
  String userName = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getUserInfoAndCheckBlockStatus();
    initializeGeoFireListener();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getUserInfoAndCheckBlockStatus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller!.dispose();
    super.dispose();
  }

  Future<void> getUserInfoAndCheckBlockStatus() async {
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snap = await usersRef.once();

    if (snap.snapshot.value != null) {
      final userData = snap.snapshot.value as Map;
      if (userData["blockStatus"] == "no") {
        setState(() {
          userName = userData["name"];
        });
      } else {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context, MaterialPageRoute(builder: (c) => const LoginScreen()));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You are blocked. Contact admin: Kumariacabs@gmail.com")));
      }
    } else {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (c) => const LoginScreen()));
    }
  }

  void initializeGeoFireListener() {
    // Your logic for GeoFire listener goes here
  }

  onBarItemClicked(int i) {
    setState(() {
      indexSelected = i;
      controller!.index = indexSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomePage(),
          MyApp1(),
          SubscriptionButton(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.credit_card),
            label: "Earnings".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_tree),
            label: "Trips".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Profile".tr(),
          ),
        ],
        currentIndex: indexSelected,
        backgroundColor: const Color.fromARGB(255, 15, 6, 77),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onBarItemClicked,
      ),
    );
  }
}
