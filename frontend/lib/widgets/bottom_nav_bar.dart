import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Garantir que o currentIndex seja válido (entre 0 e o número de itens - 1)
    // Se for negativo ou muito grande, use 0 como padrão
    final validIndex =
        (currentIndex >= 0 && currentIndex <= 3) ? currentIndex : 0;

    return BottomNavigationBar(
      currentIndex: validIndex,
      onTap: (index) async {
        if (index == 1) {
          // Índice 1 é o botão "Criar"
          // Primeiro, notificar a tela principal para pausar o vídeo
          onTap(-1); // Usamos um valor negativo como sinal para pausar o vídeo

          // Navegar para a tela de criação e aguardar o resultado
          final result = await Navigator.pushNamed(context, '/create');

          // Ao retornar da tela de criação, verificar se precisa manter os vídeos pausados
          if (result is Map && (result as Map).containsKey('pauseVideos')) {
            if (result['pauseVideos'] == true) {
              // Mantém os vídeos pausados
              onTap(-1);
            }
          }
        } else {
          onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'Criar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Mensagens',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
