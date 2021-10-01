part of 'search_cubit.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchResults extends SearchState {
  final List<ProductModel> products;

  SearchResults(this.products);
}
