import 'package:library_app/data/model/books_model.dart';
import '../repositories/book/books_repo.dart';

class FetchBooksUseCase {
  final BookRepository _booksRepository;

  FetchBooksUseCase(this._booksRepository);

  Future<List<BookModel>> call() async {
    return await _booksRepository.getAllBooks();
  }
}
