// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:library_app/data/model/books_model.dart';
// import 'package:library_app/domain/use_cases/search_book_use_cases.dart';
// import 'package:library_app/utils/console_log.dart';
// import 'package:meta/meta.dart';

// part 'search_state.dart';

// class SearchCubit extends Cubit<SearchState> {
//   final SearchBookUseCases searchBookUseCases;
//   SearchCubit(this.searchBookUseCases)
//       : super(SearchInitial(bookModel: const [])) {
//     init();
//   }

//   final Duration debounceDuration = const Duration(milliseconds: 300);
//   Timer? _searchTimer;

//   late final TextEditingController searchController;
//   late List<BookModel> bookModel;
//   void init() {
//     searchController = TextEditingController();
//   }

//   void searchBook() async {
//     try {
//       if (searchController.text.length >= 3) {
//         // Timer to avoid multiple api requests
//         _searchTimer?.cancel();
//         _searchTimer = Timer(debounceDuration, () async {
//           bookModel = await searchBookUseCases(searchController.text.trim());
//           emit(SearchInitial(bookModel: bookModel));
//         });
//       }
//     } catch (error, stackTrace) {
//       consoleLog("Erro while getting search Data>>>>>> ",
//           error: error, stackTrace: stackTrace);
//       emit(SearchLoadingError());
//     }
//   }

//   @override
//   Future<void> close() {
//     searchController.dispose();
//     bookModel = [];
//     return super.close();
//   }
// }
