import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// void main() => runApp(MyApp());

class Sorry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top:150),
        child: Center(
    child: Column(children: [
    Image.asset(
    'assets/img/logo.png',
    width: 200.0,
    height: 200.0,
    ), //   <--- image
    Text("Sorry you are out of Delivery Zone",style: TextStyle(fontSize: width/20),),
      Lottie.asset('assets/json/sad.json'),

    ],
    ),
      ),
      ),
    );
  }
}
