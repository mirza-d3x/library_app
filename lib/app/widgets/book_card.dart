import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/app/features/book_view/cubit/books_cubit.dart';
import 'package:library_app/data/model/books_model.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;

  const BookCard({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    final bool readStatus =
        BlocProvider.of<BooksCubit>(context).readBooks.contains(bookModel.key);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 6,
        shadowColor: Colors.grey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: bookModel.coverUrl,
                width: 80.0,
                height: 120.0,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('Author: ${bookModel.author}'),
                  const SizedBox(height: 4.0),
                  Text('Published on: ${bookModel.publishedYear}'),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            Row(
              children: [
                const Text('Read: '),
                CupertinoSwitch(
                  activeColor: Colors.green,
                  value: readStatus,
                  onChanged: (value) {
                    BlocProvider.of<BooksCubit>(context)
                        .toggleReadStatus(bookModel, !readStatus);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
