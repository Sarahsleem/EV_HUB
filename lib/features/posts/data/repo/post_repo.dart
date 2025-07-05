import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/features/posts/data/model/category_model.dart';

import '../../../../core/networking/error_handler.dart';
import '../model/post_model.dart';

class PostRepo {
  Dio dio;

  PostRepo({required this.dio});
  Future<Either<ApiErrorModel, List<CategoriesModel>>> getPostsCategory() async {
    try {
      final response = await dio.get('/wp/v2/categories');
      List<CategoriesModel> posts = (response.data as List)
          .map((post) => CategoriesModel.fromJson (post))
          .toList();
      print(posts.length);
      return right(posts);
    } catch (e) {
      print(e.toString());
      return left(ApiErrorHandler.handle(e));
    }

  }
  Future<Either<ApiErrorModel, List<PostModel>>> getPosts(int id) async {
    try {
      final response = await dio.get('/wp/v2/posts?categories=$id');
      List<PostModel> posts = (response.data as List)
          .map((post) => PostModel.fromJson (post))
          .toList();
      return right(posts);
    } catch (e) {
      print(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  } Future<Either<ApiErrorModel, List<PostModel>>> getPostsAll() async {
    try {
      final response = await dio.get('/wp/v2/posts');
      List<PostModel> posts = (response.data as List)
          .map((post) => PostModel.fromJson (post))
          .toList();
      return right(posts);
    } catch (e) {
      print(e.toString());
      return left(ApiErrorHandler.handle(e));
    }
  }
}