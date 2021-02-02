import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/screens/login.dart';
import 'package:cinema_customer_app/widgets/Register-button.dart';
import 'package:cinema_customer_app/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'pacifico',
                          color: kBackground,
                        ),
                      ),
                      Image.asset(
                        'assets/images/cinema.jpg',
                        height: size.height * 0.4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Get the best booking for our cinema movies!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: kBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                RoundedButton(
                  text: 'Login',
                  press: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  color: kBackground,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                RegisterButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
