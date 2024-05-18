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
        children:  const [
        HomePage(),
        EarningsPage(),
          TripsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "Earnings"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_tree),
              label: "Trips"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
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
