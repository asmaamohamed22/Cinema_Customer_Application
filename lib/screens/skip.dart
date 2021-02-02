import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SkipScreen extends StatefulWidget {
  static String id = 'SkipScreen';
  @override
  _SkipScreenState createState() => _SkipScreenState();
}

//GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _SkipScreenState extends State<SkipScreen> {
  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Carousel(
              animationDuration: Duration(seconds: 2),
              autoplay: true,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Theme.of(context).primaryColor,
              dotSize: 7,
              images: [
                AssetImage('assets/images/image6.jpg'),
                AssetImage('assets/images/image2.jpg'),
                AssetImage('assets/images/image3.jpg'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBackground,
        onPressed: () {
          Navigator.pushNamed(context, WelcomeScreen.id);
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
