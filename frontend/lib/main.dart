import 'package:flutter/material.dart';
import 'screens/home/explore_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/video/feed_screen.dart';
import 'screens/video/tiktok_feed_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VideoApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/tiktok',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/feed': (context) => const FeedScreen(),
        '/tiktok': (context) => const TikTokFeedScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
