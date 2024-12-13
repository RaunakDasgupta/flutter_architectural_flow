import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/view/my_home_page.dart';
import 'package:flutter_architectural_flow/viewmodel/app_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider<AppViewModel>(
     create: (BuildContext context) {
       return AppViewModel();
     },
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lorem Ipsum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Dogs'),
    );
  }
}


