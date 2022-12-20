import 'package:api_assignment/model/todo.dart';
import 'package:api_assignment/screen/home_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        )
      ),
      home: const HomePage(),
    );
  }
}
