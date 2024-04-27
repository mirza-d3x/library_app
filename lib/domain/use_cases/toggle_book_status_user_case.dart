import 'package:library_app/data/model/books_model.dart';

class ToggleBookStatusUseCase {
  BookModel call(BookModel book, bool readStatus) {
    final updatedBook = book.copyWith(isRead: readStatus);
    return updatedBook;
  }
}
