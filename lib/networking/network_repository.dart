import 'package:dio/dio.dart';
import 'package:tv_shows/login/login/signin_info.dart';
import 'package:tv_shows/login/register/register_info.dart';
import 'package:tv_shows/networking/auth_info.dart';
import 'package:tv_shows/networking/auth_info_holder.dart';
import 'package:tv_shows/networking/interceptors/auth_info_interceptor.dart';
import 'package:tv_shows/networking/interceptors/error_extractor_interceptor.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/shows/util/review.dart';
import 'package:tv_shows/shows/util/show.dart';

class NetworkRepository {
  AuthInfoHolder authInfoHolder;
  Dio dio = Dio();

  NetworkRepository({required this.authInfoHolder}) {
    dio.interceptors.addAll([AuthInfoInterceptor(authInfoHolder), ErrorExtractorInterceptor()]);
    dio.options.baseUrl = 'https://tv-shows.infinum.academy';
  }

  Future<User> registerUser({required RegisterInfo registerInfo}) async {
    final response = await dio.post('/users', data: registerInfo.toJson());
    authInfoHolder.info = AuthInfo.fromHeaderMap(response.headers.map);
    return User.fromJson(response.data['user']);
  }

  Future<User> signinUser({required SigninInfo signinInfo}) async {
    final response = await dio.post('/users/sign_in', data: signinInfo.toJson());
    authInfoHolder.info = AuthInfo.fromHeaderMap(response.headers.map);
    return User.fromJson(response.data['user']);
  }

  Future<List<Show>> fetchShows() async {
    final response = await dio.get('/shows');
    List<Show> shows = [];
    for (var showJson in response.data['shows']) {
      shows.add(Show.fromJson(showJson));
    }
    return shows;
  }

  Future<List<Review>> fetchReviews(String showId) async {
    final response = await dio.get('/shows/$showId/reviews');
    List<Review> reviews = [];
    for (var reviewJson in response.data['reviews']) {
      reviews.add(Review.fromJson(reviewJson));
    }

    for (var review in reviews) {
      print(review.comment);
    }
    return reviews;
  }
}
