import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/core_locator.dart';
import 'package:flutter_architectural_flow/view/admin_list_showcase_screen.dart';
import 'package:flutter_architectural_flow/view/my_home_page.dart';
import 'package:flutter_architectural_flow/viewmodel/app_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpCoreLocator();
  runApp(BlocProvider<AppViewModel>(
     create: (BuildContext context) {
       return coreLocator.get<AppViewModel>();
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
      home: AdminListShowcaseScreen(),
    );
  }
}


