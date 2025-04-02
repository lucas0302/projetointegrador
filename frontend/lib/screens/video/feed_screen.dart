import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<Map<String, dynamic>> _videos = [
    {
      'author': 'Ana Silva',
      'description': 'testetestesteastesfsdausaghashkjdasdhasdaskaa',
      'likes': 1452,
      'comments': 87,
      'shares': 32,
      'isFollowing': false,
    },
    {
      'author': 'Ricardo Tech',
      'description': 'Melhores produtos para sua estação de trabalho em 2025',
      'likes': 983,
      'comments': 54,
      'shares': 21,
      'isFollowing': true,
    },
    {
      'author': 'Camila ',
      'description': 'Aprenda a programar em Flutter em 10 minutos por dia #programação #flutter #dev',
      'likes': 3271,
      'comments': 124,
      'shares': 85,
      'isFollowing': false,
    },
    {
      'author': 'Pedro Maker',
      'description': 'Criando um app do zero - parte 1: wireframes e prototipagem',
      'likes': 752,
      'comments': 42,
      'shares': 18,
      'isFollowing': false,
    },
  ];
  
  @override
  void initState() {
    super.initState();
    // Definir orientação para portrait somente
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    // Restaurar orientações permitidas ao sair
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Seguindo',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.only(bottom: 2),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              child: const Text(
                'Para Você',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Navegar para tela de busca
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          
          return VideoPage(
            author: video['author'],
            description: video['description'],
            likes: video['likes'],
            comments: video['comments'],
            shares: video['shares'],
            isFollowing: video['isFollowing'],
            onLike: () {
              setState(() {
                _videos[index]['likes'] = video['likes'] + 1;
              });
            },
            onFollow: () {
              setState(() {
                _videos[index]['isFollowing'] = !video['isFollowing'];
              });
            },
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[700],
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
              icon: Icon(Icons.add_circle_outline, size: 40),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'Caixa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: 0, // Início selecionado
        ),
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  final String author;
  final String description;
  final int likes;
  final int comments;
  final int shares;
  final bool isFollowing;
  final VoidCallback onLike;
  final VoidCallback onFollow;

  const VideoPage({
    Key? key,
    required this.author,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isFollowing,
    required this.onLike,
    required this.onFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Camada 1: Vídeo (simulado com uma cor de fundo)
        Container(
          color: Colors.black,
          child: const Center(
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white24,
              size: 100,
            ),
          ),
        ),
        
        // Camada 2: Controles laterais
        Positioned(
          right: 16,
          bottom: 120,
          child: Column(
            children: [
              // Avatar do autor
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Botão de curtir
              Column(
                children: [
                  GestureDetector(
                    onTap: onLike,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$likes',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Botão de comentários
              Column(
                children: [
                  const Icon(
                    Icons.comment,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$comments',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Botão de compartilhar
              Column(
                children: [
                  const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$shares',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Disco girando (simulando música)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.white,
                    width: 10,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Camada 3: Informações do vídeo (autor, descrição)
        Positioned(
          left: 16,
          right: 80,
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '@$author',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isFollowing)
                    OutlinedButton(
                      onPressed: onFollow,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Seguir'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                    'Som original - $author',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
} 