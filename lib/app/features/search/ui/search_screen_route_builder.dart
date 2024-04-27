// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:library_app/app/features/search/cubit/search_cubit.dart';
// import 'package:library_app/app/features/search/ui/search_screen.dart';
// import 'package:library_app/data/repository/book_repository.dart';
// import 'package:library_app/domain/repositories/book/books_repo.dart';
// import 'package:http/http.dart' as http;
// import 'package:library_app/domain/use_cases/search_book_use_cases.dart';

// class BooksScreenRouteBuilder {
//   Widget call(BuildContext context) {
//     final BookRepository bookRepository =
//         BookRemoteDataSource(client: http.Client());
//     return BlocProvider(
//       create: (context) => SearchCubit(SearchBookUseCases(bookRepository)),
//       child: const SearchScreen(),
//     );
//   }
// }
