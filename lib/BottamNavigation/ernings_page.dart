import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';


import 'home_page.dart';



class EarningsPage extends StatefulWidget {
  const EarningsPage({Key? key}) : super(key: key);

  @override
 EarningsPagerState createState() => EarningsPagerState();
}

class EarningsPagerState extends State<EarningsPage> {
  bool _isLoading = false;

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });

    // Change the duration as needed
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          
    Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomePage()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: _isLoading
            ? LoadingAnimationWidget.threeArchedCircle(
                color: Colors.blue,
                size: 50,
              )
            : ElevatedButton(
                onPressed:() {
                  _startLoading();
               }, 
                child: Text("submit"),
                
              ),
      
    );
  }
}