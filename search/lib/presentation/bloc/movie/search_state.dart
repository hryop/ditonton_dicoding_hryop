part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchEmptyState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchHasDataState extends SearchState {
  final List<Movie> result;

  const SearchHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
