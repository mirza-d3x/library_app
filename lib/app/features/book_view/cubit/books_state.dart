part of 'books_cubit.dart';

@immutable
sealed class BooksState {}

final class BooksInitial extends BooksState {
  final List<BookModel> bookModel;

  BooksInitial({required this.bookModel});
}

final class BooksLoadingError extends BooksState {}

final class SearchLoaded extends BooksState {
  final List<BookModel> bookModel;

  SearchLoaded({required this.bookModel});
}

final class SearchLoading extends BooksState {}
