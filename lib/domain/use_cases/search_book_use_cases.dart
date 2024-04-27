import 'package:library_app/data/model/books_model.dart';
import '../repositories/book/books_repo.dart';

class SearchBookUseCases {
  final BookRepository _booksRepository;

  SearchBookUseCases(this._booksRepository);

  Future<List<BookModel>> call(String quert) async {
    return await _booksRepository.searchBooks(quert);
  }
}
