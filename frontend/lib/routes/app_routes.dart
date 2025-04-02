import 'package:flutter/material.dart';
import '../screens/welcome/welcome_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/tiktok_feed_screen.dart';
import '../screens/home/feed_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/messages/messages_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const WelcomeScreen(),
    '/welcome': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/tiktok': (context) => const TikTokFeedScreen(),
    '/feed': (context) => const FeedScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/messages': (context) => const MessagesScreen(),
  };
}
