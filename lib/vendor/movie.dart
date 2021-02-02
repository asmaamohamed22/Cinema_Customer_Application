class Movie {
  String pTitle;
  String pDescription;
  String pMovieTime;
  String pNumberSeats;
  List<dynamic> seats;
  String pCategory;
  String pImage;
  String pId;

  Movie(
      {this.pId,
      this.pImage,
      this.pTitle,
      this.pDescription,
      this.pMovieTime,
      this.pNumberSeats,
      this.seats,
      this.pCategory});
}
