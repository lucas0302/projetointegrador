import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogoText extends StatelessWidget {
  final double fontSize;
  
  const AppLogoText({
    Key? key,
    this.fontSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Video',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryPurple,
            ),
          ),
          TextSpan(
            text: 'App',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentTeal,
            ),
          ),
        ],
      ),
    );
  }
} 