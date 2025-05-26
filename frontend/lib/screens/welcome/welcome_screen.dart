import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../utils/navigation.dart';
import '../../widgets/app_logo_text.dart';
import '../../widgets/app_button.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho com logo e botões de login/cadastro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppLogoText(fontSize: 24),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          AppNavigation.navigateTo(
                            context,
                            const LoginScreen(),
                          );
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          AppNavigation.navigateTo(
                            context,
                            const RegisterScreen(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text('Criar Conta'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Conteúdo principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Texto de boas-vindas
                    const Column(
                      children: [
                        Text(
                          'Bem-vindo ao',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        AppLogoText(fontSize: 36),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Texto de descrição
                    const Text(
                      'Assista, curta e compartilhe vídeos em uma plataforma simples e moderna.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Botão de Entrar na sua conta
                    AppButton(
                      text: 'Entrar na sua conta',
                      icon: Icons.person_outline,
                      onPressed: () {
                        AppNavigation.navigateTo(
                          context,
                          const LoginScreen(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Rodapé
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '© 2025 VideoApp. Todos os direitos reservados.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
