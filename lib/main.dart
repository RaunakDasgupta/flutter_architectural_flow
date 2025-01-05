import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/core_locator.dart';
import 'package:flutter_architectural_flow/view/admin_list_showcase_screen.dart';
import 'package:flutter_architectural_flow/viewmodel/blog_content_viewmodel.dart';
import 'package:flutter_architectural_flow/viewmodel/blog_data_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await setUpCoreLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<BlogDataViewModel>(
      create: (BuildContext context) {
        return coreLocator.get<BlogDataViewModel>();
      },
    ),
    BlocProvider<BlogContentViewModel>(
      create: (BuildContext context) {
        return coreLocator.get<BlogContentViewModel>();
      },
    ),
  ], child: const MyApp(),));
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
      restorationScopeId: 'app',
      home: const AdminListShowcaseScreen(restorationId: 'main'),
    );
  }
}


