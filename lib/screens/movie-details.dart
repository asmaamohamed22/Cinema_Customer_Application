import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/vendor/movie.dart';
import 'package:cinema_customer_app/vendor/store.dart';
import 'package:cinema_customer_app/widgets/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetails extends StatefulWidget {
  static String id = 'MovieDetails';
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie movie;
  final _store = Store();
  String userId;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        userId = prefs.getString('userId');
        print('user id =-=> $userId');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Movie movie = ModalRoute.of(context).settings.arguments;
    print("---> $userId");

    // movie.seats.map(){}).toList();
    movie.seats = movie.seats.map((seat) {
      print("-=-=> ${seat.toString()}");
      if (seat['userId'] == userId) {
        return {
          'id': seat['id'],
          'isReserved': 2,
          'userId': userId,
        };
      } else {
        return seat;
      }
    }).toList();

    print("movie seats =-=> ${movie.seats}");
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          maxRadius: 90,
                          backgroundColor: kBackground,
                          child: CircleAvatar(
                            maxRadius: 80,
                            backgroundImage: NetworkImage(movie.pImage),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.67,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        movie.pTitle,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              height: 40,
                              child: FlatButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: kBackground),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie.pNumberSeats,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Seats',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 40,
                              child: FlatButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: kBackground),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: kBackground,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      movie.pMovieTime,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        movie.pDescription,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 14,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              maxRadius: 13,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Available',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          CircleAvatar(
                            maxRadius: 14,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              maxRadius: 13,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'booked',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          CircleAvatar(
                            maxRadius: 14,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              maxRadius: 13,
                              backgroundColor: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Selected',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: GridView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: movie.seats.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                int seatIndex = movie.seats.indexWhere((seat) =>
                                    seat['id'] == movie.seats[index]['id']);

                                if (movie.seats[seatIndex]['isReserved'] == 0) {
                                  setState(() {
                                    movie.seats[seatIndex]['isReserved'] = 2;
                                    movie.seats[seatIndex]['userId'] =
                                        userId ?? "";
                                  });
                                } else if (movie.seats[seatIndex]
                                        ['isReserved'] ==
                                    2) {
                                  setState(() {
                                    movie.seats[seatIndex]['isReserved'] = 0;
                                    movie.seats[seatIndex]['userId'] = '';
                                  });
                                }
                                print(
                                    "movie.seats[seatIndex]['isReserved'] ${movie.seats[seatIndex]['isReserved']}");
                              },
                              child: Container(
                                width: 2,
                                height: 2,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: () {
                                    if (movie.seats[index]['isReserved'] == 1) {
                                      return Colors.grey;
                                    } else if (movie.seats[index]
                                            ['isReserved'] ==
                                        0) {
                                      return Colors.white;
                                    } else {
                                      return Colors.green;
                                    }
                                  }(),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MyButton(
                onPressed: () async {
                  print("new movies seats =-=> ${movie.seats}");

                  List<Map<String, dynamic>> newSeatsList = [];

                  int numOfBookedSeats = 0;

                  movie.seats.forEach((seat) {
                    if (seat['isReserved'] == 2) {
                      numOfBookedSeats++;
                      newSeatsList.add({
                        'id': seat['id'],
                        'userId': userId,
                        'isReserved': 1,
                      });
                    } else {
                      newSeatsList.add(seat);
                    }
                  });

                  print("after update movies seats =-=> $newSeatsList");

                  _store.updateMovie(
                      seatsNum: 0, newSeats: newSeatsList, movieId: movie.pId);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  print("=-=---------------=> ${prefs.getString('userId')}");

                  Map<String, dynamic> userData = await _store.getUserData(
                      userId: prefs.getString('userId'));
                  print("=-=-=> movies list =-=> $userData");
                  if (userData != null) {
                    _store
                        .updateUserData(
                            bookedMovies: () {
                              if (userData.containsKey('BookingMovies')) {
                                print('1');
                                if (userData['BookingMovies'] == null) {
                                  print('2');
                                  return [
                                    {
                                      "movieId": movie.pId,
                                      "movieName": movie.pTitle,
                                      "movieTime": movie.pMovieTime,
                                      "movieImage": movie.pImage,
                                    }
                                  ];
                                } else {
                                  print('3');
                                  List<dynamic> newList = [
                                    ...userData['BookingMovies'],
                                    {
                                      "movieId": movie.pId,
                                      "movieName": movie.pTitle,
                                      "movieTime": movie.pMovieTime,
                                      "movieImage": movie.pImage,
                                    }
                                  ];
                                  return newList;
                                }
                              } else {
                                print('4');
                                return userData['BookingMovies'] = [
                                  {
                                    "movieId": movie.pId,
                                    "movieName": movie.pTitle,
                                    "movieTime": movie.pMovieTime,
                                    "movieImage": movie.pImage,
                                  }
                                ];
                              }
                            }(),
                            userId: prefs.getString('userId'))
                        .then((value) => _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Movie Booked Successfully'),
                              ),
                            ));
                  }

                  _store.addBookedDataToNotifications(
                      allBookedSeats: newSeatsList
                          .where((item) => item['isReserved'] == 1)
                          .length
                          .toString(),
                      availableSeats: newSeatsList
                          .where((item) => item['isReserved'] == 0)
                          .length
                          .toString(),
                      movieId: movie.pId,
                      movieImage: movie.pImage,
                      movieTime: movie.pMovieTime,
                      movieName: movie.pTitle,
                      userBookedSeats: numOfBookedSeats.toString());

                  // send notification to vendor
                  _store
                      .sendAndRetrieveMessage(
                          title: movie.pTitle,
                          body:
                              '$numOfBookedSeats seats has been booked successfully, available seats now ${newSeatsList.where((item) => item['isReserved'] == 0).length.toString()}',
                          movieId: movie.pId)
                      .then((data) {
                    print("---------- ${data?.toString()}");
                  }).catchError((err) {
                    print("erererere>>> $err");
                  });
                },
                name: 'Booking Now',
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
