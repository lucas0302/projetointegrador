import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/video_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.home, color: Colors.grey[700]),
            const SizedBox(width: 12),
            const Text(
              'Descubra',
              style: TextStyle(
                color: AppTheme.primaryPurple,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const Text(
              ' Vídeos',
              style: TextStyle(
                color: AppTheme.accentTeal,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.grey[700]),
            onPressed: () {
              // Navegar para perfil do usuário
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título da seção
              const Text(
                'Vídeos em Destaque',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              
              // Subtítulo da seção
              Text(
                'Explore os melhores conteúdos selecionados para você',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              
              // Lista de vídeos
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/tiktok'),
                    child: const VideoCard(
                      thumbnail: 'assets/images/video1.jpg', 
                      title: 'Como montar um home office eficiente',
                      authorName: 'Ana Silva',
                      views: '45K visualizações',
                      likes: 245,
                      duration: '12:34',
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/tiktok'),
                    child: const VideoCard(
                      thumbnail: 'assets/images/video2.jpg', 
                      title: 'Review: Os melhores produtos para sua workstation',
                      authorName: 'Ricardo Tech',
                      views: '32K visualizações',
                      likes: 189,
                      duration: '08:21',
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/tiktok'),
                    child: const VideoCard(
                      thumbnail: 'assets/images/video3.jpg', 
                      title: 'Aprenda a programar em 10 minutos por dia',
                      authorName: 'Camila Dev',
                      views: '102K visualizações',
                      likes: 521,
                      duration: '15:45',
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/tiktok'),
                    child: const VideoCard(
                      thumbnail: 'assets/images/video4.jpg', 
                      title: 'Dicas para aumentar sua produtividade',
                      authorName: 'João Produtivo',
                      views: '28K visualizações',
                      likes: 310,
                      duration: '09:17',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primaryPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 30),
            label: 'Criar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Mensagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 1, // Explorar selecionado
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/tiktok');
          }
        },
      ),
    );
  }
} 