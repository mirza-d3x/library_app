// core/data/book_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_app/data/model/books_model.dart';
import 'package:library_app/domain/repositories/book/books_repo.dart';
import 'package:library_app/utils/console_log.dart';

class BookRemoteDataSource implements BookRepository {
  final http.Client client;

  BookRemoteDataSource({required this.client});

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    consoleLog("Search request sent to "
        'https://openlibrary.org/search.json?q=$query');
    final response = await client
        .get(Uri.parse('https://openlibrary.org/search.json?q=$query'));

    consoleLog("Search Books Response>>> ${response.body}");
    return BookModel.listFromJsonSearch(jsonDecode(response.body));
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    final response = await client.get(Uri.parse(
        'https://openlibrary.org/people/mekBot/books/already-read.json'));
    consoleLog("Get Books Response>>> ${response.body}");

    return BookModel.listFromJson(jsonDecode(response.body));
  }
}
