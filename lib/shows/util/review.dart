class Review {
  String? comment = '';
  int rating = 0;
  String userEmail = '';
  String imageUrl = '';

  Review({this.comment, required this.rating, required this.userEmail, required this.imageUrl});

  static final allReviews = [
    Review(
        comment: 'This show was a complete masterpiece, I really liked it.',
        rating: 5,
        userEmail: 'imenko.prezimenovic',
        imageUrl: 'assets/images/shows/profile_pic.svg'),
    Review(rating: 3, userEmail: 'branimir.akmadza', imageUrl: 'assets/images/shows/profile_pic.svg'),
    Review(
        comment: 'It was good. I laughed a lot, it matches my sense of humor perfectly. Loved it!',
        rating: 5,
        userEmail: 'testamenko.testamenovic.testamenski.covjek',
        imageUrl: 'assets/images/shows/profile_pic.svg')
  ];
}
