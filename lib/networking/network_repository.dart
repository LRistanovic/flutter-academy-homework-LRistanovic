import 'package:dio/dio.dart';
import 'package:tv_shows/login/login/signin_info.dart';
import 'package:tv_shows/login/register/register_info.dart';
import 'package:tv_shows/networking/interceptors/auth_info_interceptor.dart';
import 'package:tv_shows/networking/interceptors/error_extractor_interceptor.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/storage_repository.dart';
import 'package:tv_shows/shows/util/new_review_info.dart';
import 'package:tv_shows/shows/util/review.dart';
import 'package:tv_shows/shows/util/show.dart';

class NetworkRepository {
  StorageRepository storageRepository;
  Dio dio = Dio();

  NetworkRepository({required this.storageRepository}) {
    dio.interceptors.addAll([AuthInfoInterceptor(storageRepository), ErrorExtractorInterceptor()]);
    dio.options.baseUrl = 'https://tv-shows.infinum.academy';
  }

  Future<User> registerUser({required RegisterInfo registerInfo}) async {
    final response = await dio.post('/users', data: registerInfo.toJson());
    final user = User.fromJson(response.data['user']);
    storageRepository.storeUserInfo(user, response.headers.map);
    return user;
  }

  Future<User> signinUser({required SigninInfo signinInfo}) async {
    final response = await dio.post('/users/sign_in', data: signinInfo.toJson());
    final user = User.fromJson(response.data['user']);
    await storageRepository.storeUserInfo(user, response.headers.map);
    return user;
  }

  Future<User> updateEmail({required String email}) async {
    final response = await dio.put('/users', data: {'email': email});
    final user = User.fromJson(response.data['user']);
    await storageRepository.storeUserInfo(user, response.headers.map);
    return user;
  }

  Future<User> updateImage({required String imagePath}) async {
    final response = await dio.put(
      '/users',
      data: FormData.fromMap({
        'image': MultipartFile.fromFile(imagePath, filename: imagePath),
      }),
    );
    final user = User.fromJson(response.data['user']);
    storageRepository.storeUserInfo(user, response.headers.map);
    return user;
  }

  Future<User> updateEmailAndImage({required String email, required String imagePath}) async {
    final response = await dio.put(
      '/users',
      data: FormData.fromMap({
        'image': MultipartFile.fromFile(imagePath),
        'email': email,
      }),
    );
    final user = User.fromJson(response.data['user']);
    storageRepository.storeUserInfo(user, response.headers.map);
    return user;
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
    return reviews;
  }

  Future<Review> postReview({required NewReviewInfo reviewInfo}) async {
    final response = await dio.post('/reviews', data: reviewInfo.toJson());
    return Review.fromJson(response.data['review']);
  }
}
