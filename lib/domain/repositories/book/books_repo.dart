import 'package:library_app/data/model/books_model.dart';

abstract class BookRepository {
  Future<List<BookModel>> getAllBooks();
  Future<List<BookModel>> searchBooks(String query);
}
