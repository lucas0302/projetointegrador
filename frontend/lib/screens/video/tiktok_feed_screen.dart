import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

class TikTokFeedScreen extends StatefulWidget {
  const TikTokFeedScreen({Key? key}) : super(key: key);

  @override
  State<TikTokFeedScreen> createState() => _TikTokFeedScreenState();
}

class _TikTokFeedScreenState extends State<TikTokFeedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLiked = false;
  bool _isBookmarked = false;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _videos = [
    {
      'author': 'ana.dev',
      'description':
          'Como montar um home office eficiente com poucos recursos #homeoffice #setup #dev',
      'likes': '1.4M',
      'comments': '4.2K',
      'shares': '12.5K',
      'music': 'Som original - ana.dev',
      'isFollowing': false,
      'authorAvatar': 'https://randomuser.me/api/portraits/women/44.jpg',
    },
    {
      'author': 'tech.master',
      'description':
          'Melhores produtos tech para sua estação de trabalho em 2025 #tech #workstation #setup',
      'likes': '983K',
      'comments': '2.1K',
      'shares': '5.4K',
      'music': 'Tech Vibes - Popular',
      'isFollowing': true,
      'authorAvatar': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'author': 'flutter.code',
      'description':
          'Aprenda a programar em Flutter em 10 minutos por dia! Code with me 💙 #flutter #dev #coding',
      'likes': '3.2M',
      'comments': '8.7K',
      'shares': '22.3K',
      'music': 'Coding Mix - Lo-Fi',
      'isFollowing': false,
      'authorAvatar': 'https://randomuser.me/api/portraits/women/68.jpg',
    },
    {
      'author': 'design.pro',
      'description':
          'Criando uma interface do zero no Figma - parte 1: wireframes e prototipagem #ux #ui #design',
      'likes': '752K',
      'comments': '1.8K',
      'shares': '3.5K',
      'music': 'Design Process - UX Sounds',
      'isFollowing': false,
      'authorAvatar': 'https://randomuser.me/api/portraits/men/46.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Definir orientação para portrait somente
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Configurar a barra de status e navegação
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    // Restaurar orientações e barras do sistema
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _isLiked = false;
      _isBookmarked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        scrollDirection: Axis.vertical,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return Stack(
            children: [
              // Placeholder para o vídeo
              Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),

              // Informações do vídeo
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Lado esquerdo - Informações do autor e descrição
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    video['authorAvatar'],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '@${video['author']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        video['isFollowing']
                                            ? Colors.transparent
                                            : Colors.red,
                                    border: Border.all(
                                      color:
                                          video['isFollowing']
                                              ? Colors.white
                                              : Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    video['isFollowing']
                                        ? 'Seguindo'
                                        : 'Seguir',
                                    style: TextStyle(
                                      color:
                                          video['isFollowing']
                                              ? Colors.white
                                              : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              video['description'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  video['music'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Lado direito - Botões de interação
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildActionButton(
                            icon:
                                _isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                            label: video['likes'],
                            onTap: () {
                              setState(() {
                                _isLiked = !_isLiked;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildActionButton(
                            icon:
                                _isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                            onTap: () {
                              setState(() {
                                _isBookmarked = !_isBookmarked;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 4) {
            // Índice do item Perfil
            Navigator.pushNamed(context, '/profile');
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Descobrir'),
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
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    String? label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
