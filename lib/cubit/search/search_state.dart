part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {} 

class SearchLoading extends SearchState {}

class SearchResults extends SearchState {
  final List<ProductModel> products;

  SearchResults(this.products);
}
