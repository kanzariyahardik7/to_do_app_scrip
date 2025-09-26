import 'package:app_scrip/app_dependency/get_it_depencency.dart';
import 'package:app_scrip/routing/app_router.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/view_models/login_view_model.dart';
import 'package:app_scrip/view_models/register_view_model.dart';
import 'package:app_scrip/view_models/task_view_model.dart';
import 'package:app_scrip/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator(); // set up all dependency of the project
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => getIt<LoginViewModel>(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => getIt<RegisterViewModel>(),
        ),
        ChangeNotifierProvider<UserViewModel>(
          create: (context) => getIt<UserViewModel>(),
        ),
        ChangeNotifierProvider<TaskViewModel>(
          create: (context) => getIt<TaskViewModel>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: deepPurple),
      ),
      routerConfig:
          AppRouter.router, // Use router if defined in a separate file
      builder: (context, child) {
        return child!;
      },
    );
  }
}
