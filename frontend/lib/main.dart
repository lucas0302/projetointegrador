import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VideoApp',
      theme: ThemeData(
        primaryColor: AppTheme.primaryPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
