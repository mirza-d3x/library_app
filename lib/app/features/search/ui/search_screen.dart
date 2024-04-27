// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:library_app/app/features/search/cubit/search_cubit.dart';
// import 'package:library_app/app/widgets/book_card.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Search for Books",
//             style: TextStyle(color: Colors.white),
//           ),
//           elevation: 5,
//           centerTitle: true,
//           backgroundColor: Colors.blue,
//         ),
//         body: Container(
//           padding: const EdgeInsets.only(left: 16, right: 16),
//           height: size.height,
//           width: size.width,
//           child: BlocBuilder<SearchCubit, SearchState>(
//             builder: (context, state) {
//               if (state is SearchInitial) {
//                 if (state.bookModel.isEmpty) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return ListView.builder(
//                     itemCount: state.bookModel.length,
//                     itemBuilder: (BuildContext context, int index) => BookCard(
//                       bookModel: state.bookModel[index],
//                     ),
//                   );
//                 }
//               } else if (state is SearchLoadingError) {
//                 return const Center(
//                   child: Text("Error while Loading Books"),
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
