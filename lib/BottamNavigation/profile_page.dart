// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/material_buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(top: 12, left: 150),
                            child: const Text(
                              "Settings",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right:10,top: 10),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:Colors.black87,
                                        elevation: 20,
                                        title:const TextEdt(
                                          text: 'Email Sign Out',
                                          color: Colors.white,
                                          fontSize: null,
                                        ),
                                        content: const TextEdt(
                                          text:
                                              'Do you want to continue with sign out?',
                                          fontSize: null,
                                          color: Colors.grey,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              MaterialButtons(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                elevationsize: 20,
                                                text: '   Cancel    ',
                                                fontSize: 17,
                                                containerheight: 40,
                                                containerwidth: 100,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                onPressed: null,
                                              ),
                                              MaterialButtons(
                                                onTap: () {
                                                  _signOut();
                                                  Navigator.of(context).pop();
                                                },
                                                elevationsize: 20,
                                                text: 'Continue',
                                                fontSize: 17,
                                                containerheight: 40,
                                                containerwidth: 100,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                onPressed: null,
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.power_settings_new,),
                              color: Colors.red,
                              iconSize: 30,
                              
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/user.jpg"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          containerList("Name",
                              "You can change name and surname", Icons.person),
                          const SizedBox(
                            height: 15,
                          ),
                       
                          containerList("Email", "You can change email",
                              Icons.email),
                          const SizedBox(
                            height: 15,
                          ),
                          containerList("Mobile Number",
                              "", Icons.phone),
                          const SizedBox(
                            height: 15,
                          ),
                         /* containerList("Change Language",
                              "You can change Language", Icons.language),
                          const SizedBox(
                            height: 15,
                          ),*/
                        
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerList(String title, String subtitle, IconData icon) {
    return Material(
      elevation: 10,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: ListTile(
          onTap: () {},
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 15,
          ),
        ),
      ),
    );
  }
}
