import 'dart:async';
import 'dart:convert';
import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/vendor/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addMovie(Movie movie) async {
    await _firestore.collection(kMoviesCollection).add({
      kMovieImage: movie.pImage,
      kMovieTitle: movie.pTitle,
      kMovieDescription: movie.pDescription,
      kMovieTime: movie.pMovieTime,
      kMovieNumberSeats: movie.pNumberSeats,
      kMovieCategory: movie.pCategory,
    });
  }

  Future<Map<String, dynamic>> getUserData({String userId}) async {
    DocumentSnapshot userData =
        await _firestore.collection('User').doc('$userId').get();
    print(userData.data().toString());
    return userData.data();
  }

  Future<DocumentSnapshot> getUserBookedMovies({String userId}) async {
    DocumentSnapshot userData =
        await _firestore.collection('User').doc('$userId').get();
    print(userData.data().toString());
    return userData;
  }

  updateMovie(
      {List<Map<String, dynamic>> newSeats,
      int seatsNum,
      String movieId}) async {
    print(
        "=-=-=> ${newSeats.map((seat) => seat['isReserved'] == 0).toList().length.toString()}");
    await _firestore.collection(kMoviesCollection).doc('$movieId').set({
      'seats': newSeats,
      'movieNumberSeats':
          newSeats.where((item) => item['isReserved'] == 0).length.toString(),
    }, SetOptions(merge: true));
  }

  updateUserData({List<dynamic> bookedMovies, String userId}) async {
    print("from updating -=> $userId");
    print("from updating -=> $bookedMovies");
    await _firestore.collection('User').doc('$userId').set({
      'BookingMovies': bookedMovies,
    }, SetOptions(merge: true));
  }

  addBookedDataToNotifications(
      {@required String movieId,
      @required String movieName,
      @required String movieTime,
      @required String movieImage,
      @required String availableSeats,
      @required String userBookedSeats,
      @required String allBookedSeats}) async {
    _firestore.collection("Notifications").add({
      "movieId": movieId,
      "movieName": movieName,
      "movieTime": movieTime,
      "movieImage": movieImage,
      "availableSeats": availableSeats,
      "userBookedSeats": userBookedSeats,
      "allBookedSeats": allBookedSeats,
    }).then((_) {
      print("Vendor get Notification");
    }).catchError((_) {
      print("an error occured");
    });
  }

  Stream<QuerySnapshot> loadMovie() {
    return _firestore.collection(kMoviesCollection).snapshots();
  }

  // Replace with server token from firebase console settings.
  final String serverToken =
      'AAAAKmbmUJI:APA91bEg3P4l5ApF8769USdovjOPi92nM9p5_wb6DZD9Iky6tVTzovT2hyV9FOxcsCUYo2JnD9AR66UEYI-ooofFv4UbzosdgUWT8eNNAePGJSyy-wj6s_kKU7sw4c5rMajzlA-rs9FY';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage({
    String body,
    String title,
    String movieId,
  }) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body ?? 'this is a body',
            'title': title ?? 'this is a title',
            'movieId': movieId,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'movieId': movieId,
          },
          'to': '/topics/booking_new_movie',
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
