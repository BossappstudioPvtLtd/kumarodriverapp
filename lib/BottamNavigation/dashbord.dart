import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/BottamNavigation/ernings_page.dart';
import 'package:kumari_drivers/BottamNavigation/home_page.dart';
import 'package:kumari_drivers/BottamNavigation/profile_page.dart';
import 'package:kumari_drivers/BottamNavigation/trips_page.dart';

class Dashboard extends StatefulWidget
{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin
{
  TabController? controller;
  int indexSelected = 0;


  onBarItemClicked(int i)
  {
    setState(() {
      indexSelected = i;
      controller!.index = indexSelected;
    });
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children:   [
        HomePage(),
        EarningsPage(),
          GalleryScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: 
        [
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
        selectedItemColor:  Colors.amber,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onBarItemClicked,
      ),
    );
  }
}
