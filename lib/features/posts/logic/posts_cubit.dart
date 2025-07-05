import 'package:bloc/bloc.dart';
import 'package:evhub/features/posts/data/repo/post_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/category_model.dart';
import '../data/model/post_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.postRepo) : super(PostsInitial());
  static PostsCubit get(context) => BlocProvider.of(context);
  PostRepo postRepo;
  List<PostModel> posts = [];
  List<CategoriesModel> categories = [];

  Future<void> getPostsCategory() async {
    emit(PostsCategoryLoadingState());
    var response = await postRepo.getPostsCategory();
    response.fold((l) => emit(PostsCategoryErrorState()), (r) {


      categories = r;
      print('categories.length');
      emit(PostsCategorySuccessState());
    });
  }
  Future<void> getPostsAll() async {
    emit(PostsLoadingState());
    var response = await postRepo.getPostsAll();
    response.fold((l) => emit(PostsErrorState()), (r) {
      posts = r;
      emit(PostsSuccessState());
    });
  }
  Future<void> getPostsByCategory(int id) async {
    emit(PostsLoadingState());
    var response = await postRepo.getPosts(id);
    response.fold((l) => emit(PostsErrorState()), (r) {
      posts = r;
      emit(PostsSuccessState());
    });
  }
  int currentIndex = -1;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
  bool writeComment = false;
  void changeWriteComment() {
    writeComment = !writeComment;
    emit(ChangeWriteCommentState());
  }
}
