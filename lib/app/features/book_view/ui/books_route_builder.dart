import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/app/features/book_view/cubit/books_cubit.dart';
import 'package:library_app/app/features/book_view/ui/books_screen.dart';
import 'package:library_app/data/repository/book_repository.dart';
import 'package:library_app/domain/repositories/book/books_repo.dart';
import 'package:library_app/domain/use_cases/fetch_books_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/domain/use_cases/search_book_use_cases.dart';
import 'package:library_app/domain/use_cases/toggle_book_status_user_case.dart';

class BooksScreenRouteBuilder {
  Widget call(BuildContext context) {
    final BookRepository bookRepository =
        BookRemoteDataSource(client: http.Client());
    return BlocProvider(
      create: (context) => BooksCubit(FetchBooksUseCase(bookRepository),
          ToggleBookStatusUseCase(), SearchBookUseCases(bookRepository)),
      child: const BooksScreen(),
    );
  }
}
