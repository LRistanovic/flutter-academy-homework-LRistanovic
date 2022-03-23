class Show {
  String name = '';
  String description = '';
  int numOfReviews = 0;
  double? averageRating;
  String imageUrl = '';

  Show(this.name, this.description, this.numOfReviews, this.averageRating, this.imageUrl);

  static final allShows = [
    Show(
        'The Office',
        'The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company. It aired on NBC from March 24, 2005, to May 16, 2013, lasting a total of nine seasons.',
        3,
        4.33,
        'assets/images/shows/the_office.png'),
    Show(
        'Stranger Things',
        'Stranger Things is an American science fiction horror drama television series created by the Duffer Brothers and streaming on Netflix. The brothers serve as showrunners and are executive producers along with Shawn Levy and Dan Cohen. The series premiered on Netflix on July 15, 2016.',
        4,
        3.33,
        'assets/images/shows/stranger_things.png'),
    Show(
        'Krv nije voda',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        5,
        5.0,
        'assets/images/shows/krv_nije_voda.png')
  ];
}
