import 'package:flutter/material.dart';
import 'package:library_app/services/navigation_services/navigation.dart';
import 'package:library_app/services/navigation_services/route_names.dart';

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.splash,
      onGenerateRoute: onGenerateAppRoute(
        AppRoutesFactory(),
      ),
    );
  }
}
