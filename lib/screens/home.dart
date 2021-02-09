import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/screens/login.dart';
import 'package:cinema_customer_app/screens/movie-details.dart';
import 'package:cinema_customer_app/vendor/movie.dart';
import 'package:cinema_customer_app/vendor/store.dart';
import 'package:cinema_customer_app/widgethome/functions.dart';
import 'package:cinema_customer_app/widgethome/movieView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'booked.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _store = Store();

  List<Movie> _movies;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      print("-----------=> ${prefs.getString('userId')}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: UnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kBackground,
              onTap: (value) {
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.movie,
                    size: 25,
                  ),
                  icon: IconButton(
                    icon: Icon(
                      Icons.movie,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.id);
                    },
                  ),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(
                      Icons.restore,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, BookingMovies.id);
                    },
                  ),
                  label: 'Mybooked',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.exit_to_app,
                    size: 25,
                  ),
                  icon: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 25,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then(
                        (value) {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                      );
                    },
                  ),
                  label: 'Logout',
                ),
              ],
              selectedLabelStyle: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: TabBar(
                indicatorColor: kBackground,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Action',
                    style: TextStyle(
                        fontSize: _tabBarIndex == 0 ? 16 : null,
                        color:
                            _tabBarIndex == 0 ? Colors.black : UnActiveColor),
                  ),
                  Text(
                    'Comedy',
                    style: TextStyle(
                        fontSize: _tabBarIndex == 1 ? 16 : null,
                        color:
                            _tabBarIndex == 1 ? Colors.black : UnActiveColor),
                  ),
                  Text(
                    'Drama',
                    style: TextStyle(
                        fontSize: _tabBarIndex == 2 ? 16 : null,
                        color:
                            _tabBarIndex == 2 ? Colors.black : UnActiveColor),
                  ),
                  Text(
                    'Horror',
                    style: TextStyle(
                        fontSize: _tabBarIndex == 3 ? 16 : null,
                        color:
                            _tabBarIndex == 3 ? Colors.black : UnActiveColor),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                actionView(),
                moviesView(mComedy, _movies),
                moviesView(mDrama, _movies),
                moviesView(mHorror, _movies),
              ],
            ),
          ),
        ),
        Material(
          child: Container(
            color: Colors.white,
            height: size.height * 0.13,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cinema',
                    style: TextStyle(
                        fontSize: 35.0,
                        color: kBackground,
                        fontFamily: 'pacifico'),
                  ),
                  Text(
                    '🎥',
                    style: TextStyle(
                        fontSize: 35.0,
                        color: kBackground,
                        fontFamily: 'pacifico'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget actionView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadMovie(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Movie> movies = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();

              movies.add(Movie(
                pId: doc.id,
                pImage: data[kMovieImage],
                seats: data['seats'],
                pTitle: data[kMovieTitle],
                pDescription: data[kMovieDescription],
                pMovieTime: data[kMovieTime],
                pNumberSeats: data[kMovieNumberSeats],
                pCategory: data[kMovieCategory],
              ));
            }
            _movies = [...movies];
            movies.clear();
            movies = getmovieByCategory(mAction, _movies);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    print("--->movies[index].seats.toString()}");
                    Navigator.pushNamed(context, MovieDetails.id,
                        arguments: movies[index]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: movies[index].pImage == null
                              ? Container()
                              : Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(movies[index].pImage),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.black87,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movies[index].pTitle,
                                    style: TextStyle(
                                      color: kBackground,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Row(
                                    children: [
                                      Text(
                                        movies[index].pMovieTime,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: movies.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
