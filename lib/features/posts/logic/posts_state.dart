part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}
class PostsCategorySuccessState extends PostsState {}
class PostsCategoryErrorState extends PostsState {}
class PostsCategoryLoadingState extends PostsState {}
class PostsSuccessState extends PostsState {}
class PostsErrorState extends PostsState {}
class PostsLoadingState extends PostsState {}
class ChangeIndexState extends PostsState{}
class ChangeWriteCommentState extends PostsState{}
