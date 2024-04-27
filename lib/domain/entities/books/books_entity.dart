import 'package:library_app/data/model/books_model.dart';

class BookEntity {
  final String title;
  final String author;
  final int publishedYear;
  final bool isRead;
  final String key;

  const BookEntity({
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.isRead,
    required this.key,
  });

  BookModel toModel() => BookModel(
        title: title,
        author: author,
        publishedYear: publishedYear,
        isRead: isRead,
        coverUrl: '',
        key: key,
      );
}
