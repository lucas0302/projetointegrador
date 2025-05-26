import 'package:flutter/material.dart';

class AppNavigation {
  // Método para navegação normal (push)
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Método para navegação com substituição (pushReplacement)
  static void navigateToReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Método para navegação e remoção de todas as rotas anteriores (pushAndRemoveUntil)
  static void navigateAndRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  // Método para voltar à tela anterior
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
} 