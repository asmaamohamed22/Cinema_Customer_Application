import 'dart:ui';

import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/vendor/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingMovies extends StatefulWidget {
  static String id = 'BookingMovies';
  @override
  _BookingMoviesState createState() => _BookingMoviesState();
}

class _BookingMoviesState extends State<BookingMovies> {
  Store _store = Store();

  String userId;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString('userId');
      setState(() {});
      //_store.getUserData(userId: userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text('My Booking'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: _store.getUserBookedMovies(userId: userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Check Your Internet Connection'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['BookingMovies'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: Container(
                        height: size.height * 0.13,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 55,
                              backgroundImage: NetworkImage(snapshot
                                  .data['BookingMovies'][index]['movieImage']),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['BookingMovies'][index]
                                      ['movieName'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  snapshot.data['BookingMovies'][index]
                                      ['movieTime'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Container(),
              );
            }
          }),
    );
  }
}
