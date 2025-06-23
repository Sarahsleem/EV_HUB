import 'package:bloc/bloc.dart';
import 'package:evhub/features/search/data/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  SearchRepo searchRepo;
  static SearchCubit get(context) => BlocProvider.of(context);
}
