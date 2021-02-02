import 'package:cinema_customer_app/screens/booked.dart';
import 'package:cinema_customer_app/screens/home.dart';
import 'package:cinema_customer_app/screens/login.dart';
import 'package:cinema_customer_app/screens/movie-details.dart';
import 'package:cinema_customer_app/screens/register.dart';
import 'package:cinema_customer_app/screens/skip.dart';
import 'package:cinema_customer_app/screens/splash.dart';
import 'package:cinema_customer_app/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyCustomer());
}

class MyCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        primaryColor: Color(0xFFF9A826),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return Splash();
          }
        },
      ),
      routes: {
        Splash.id: (context) => Splash(),
        SkipScreen.id: (context) => SkipScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        MovieDetails.id: (context) => MovieDetails(),
        BookingMovies.id: (context) => BookingMovies(),
      },
    );
  }
}
