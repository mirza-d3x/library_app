import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/app/features/book_view/cubit/books_cubit.dart';
import 'package:library_app/app/widgets/book_card.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Library",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 5,
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              TextField(
                controller: BlocProvider.of<BooksCubit>(context)
                    .searchController, // Connect to SearchCubit
                decoration: const InputDecoration(
                  hintText: 'Search books (min. 3 characters)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              Expanded(
                child: BlocBuilder<BooksCubit, BooksState>(
                  builder: (context, state) {
                    if (state is BooksInitial) {
                      if (state.bookModel.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.bookModel.length,
                          itemBuilder: (BuildContext context, int index) =>
                              BookCard(
                            bookModel: state.bookModel[index],
                          ),
                        );
                      }
                    }
                    if (state is SearchLoaded) {
                      if (state.bookModel.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.bookModel.length,
                          itemBuilder: (BuildContext context, int index) =>
                              BookCard(
                            bookModel: state.bookModel[index],
                          ),
                        );
                      }
                    } else if (state is SearchLoading) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Searching For results"),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator()
                          ],
                        ),
                      );
                    } else if (state is BooksLoadingError) {
                      return const Center(
                        child: Text("Error while Loading Books"),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
