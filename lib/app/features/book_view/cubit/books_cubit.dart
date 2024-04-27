import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_app/constants/Keys/secured_storage_key.dart';
import 'package:library_app/data/model/books_model.dart';
import 'package:library_app/domain/use_cases/fetch_books_use_case.dart';
import 'package:library_app/domain/use_cases/search_book_use_cases.dart';
import 'package:library_app/domain/use_cases/toggle_book_status_user_case.dart';
import 'package:library_app/services/local_data/secured_storage/secured_storage.dart';
import 'package:library_app/utils/console_log.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final FetchBooksUseCase fetchBooksUseCase;
  final ToggleBookStatusUseCase toggleBookStatusUseCase;
  final SearchBookUseCases searchBookUseCases;

  BooksCubit(this.fetchBooksUseCase, this.toggleBookStatusUseCase,
      this.searchBookUseCases)
      : super(BooksInitial(bookModel: const [])) {
    init();
  }

  final Duration debounceDuration = const Duration(seconds: 1);
  Timer? _searchTimer;

  late final TextEditingController searchController;

  late List<BookModel> books = [];
  late List<BookModel> searchBooks = [];

  late final SecuredStorage securedStorage;
  String readBooks = "";

  void init() {
    consoleLog("Books Cubit initializing");
    securedStorage = SecuredStorage();
    searchController = TextEditingController()
      ..addListener(() {
        searchForBooks();
      });
    getReadedBooksFromStorage();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      books = await fetchBooksUseCase(); // Call UseCase
      emit(BooksInitial(bookModel: books)); // Emit BooksLoaded state
    } catch (error, stackTrace) {
      consoleLog("Book loading error", error: error, stackTrace: stackTrace);
      emit(BooksLoadingError());
    }
  }

  void toggleReadStatus(BookModel bookModel, bool readStatus) {
    try {
      updateReadStatusStorage(bookModel.key);
      final updatedIndex = books.indexOf(bookModel);
      if (updatedIndex != -1) {
        final updatedBook = toggleBookStatusUseCase(bookModel, readStatus);
        books[updatedIndex] = updatedBook;

        emit(BooksInitial(bookModel: books)); // Emit updated BooksLoaded state
      }

      final searchIndex = searchBooks.indexOf(bookModel);
      if (searchIndex != -1) {
        final updatedBook = toggleBookStatusUseCase(bookModel, readStatus);
        searchBooks[searchIndex] = updatedBook;
        emit(BooksInitial(
            bookModel: searchBooks)); // Emit updated search results
      }
    } catch (error, stackTrace) {
      consoleLog("Error while changing Read status",
          error: error, stackTrace: stackTrace);
    }
  }

  void searchForBooks() async {
    try {
      if (searchController.text.isNotEmpty &&
          searchController.text.length >= 3) {
        emit(SearchLoading());
        final String searchQuery = searchController.text.trim();
        // Timer to avoid multiple api requests
        _searchTimer?.cancel();
        _searchTimer = Timer(debounceDuration, () async {
          searchBooks = await searchBookUseCases(searchQuery);
          if (searchController.text.isNotEmpty &&
              searchController.text.length >= 3) {
            emit(BooksInitial(bookModel: searchBooks));
          }
        });
      } else if (searchController.text.isEmpty) {
        _searchTimer?.cancel();
        emit(BooksInitial(bookModel: books));
      }
    } catch (error, stackTrace) {
      _searchTimer?.cancel();
      consoleLog("Erro while getting search Data>>>>>> ",
          error: error, stackTrace: stackTrace);

      emit(BooksLoadingError());
    }
  }

  void getReadedBooksFromStorage() async {
    try {
      readBooks = "";
      final response = await securedStorage.get(SecuredStorageKeys().readBook);
      if (response != null && response.isNotEmpty) {
        readBooks = response;
      }
      consoleLog(response!);
    } catch (error, stackTrace) {
      consoleLog("Error while getting Data From Storage",
          error: error, stackTrace: stackTrace);
    }
  }

  void updateReadStatusStorage(String bookKey) async {
    try {
      if (readBooks.contains(bookKey)) {
        readBooks = readBooks.replaceAll(bookKey, '');

        await securedStorage.save(
          key: SecuredStorageKeys().readBook,
          value: readBooks,
        );
      } else {
        readBooks = readBooks + bookKey;
        await securedStorage.save(
            key: SecuredStorageKeys().readBook, value: readBooks);
      }
    } catch (error, stackTrace) {
      consoleLog("Error while saving data",
          error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> close() {
    books = [];
    searchBooks = [];
    _searchTimer?.cancel();
    return super.close();
  }
}
