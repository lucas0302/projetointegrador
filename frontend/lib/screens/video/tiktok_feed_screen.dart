import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

class TikTokFeedScreen extends StatefulWidget {
  const TikTokFeedScreen({Key? key}) : super(key: key);

  @override
  State<TikTokFeedScreen> createState() => _TikTokFeedScreenState();
}

class _TikTokFeedScreenState extends State<TikTokFeedScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;
  int _currentPage = 0;
  bool _isLiked = false;
  bool _isBookmarked = false;
  
  final List<Map<String, dynamic>> _videos = [
    {
      'author': 'ana.dev',
      'description': 'Como montar um home office eficiente com poucos recursos #homeoffice #setup #dev',
      'likes': '1.4M',
      'comments': '4.2K',
      'shares': '12.5K',
      'music': 'Som original - ana.dev',
      'isFollowing': false,
      'authorAvatar': 'https://randomuser.me/api/portraits/women/44.jpg',
    },
    {
      'author': 'tech.master',
      'description': 'Melhores produtos tech para sua estação de trabalho em 2025 #tech #workstation #setup',
      'likes': '983K',
      'comments': '2.1K',
      'shares': '5.4K',
      'music': 'Tech Vibes - Popular',
      'isFollowing': true,
      'authorAvatar': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'author': 'flutter.code',
      'description': 'Aprenda a programar em Flutter em 10 minutos por dia! Code with me 💙 #flutter #dev #coding',
      'likes': '3.2M',
      'comments': '8.7K',
      'shares': '22.3K',
      'music': 'Coding Mix - Lo-Fi',
      'isFollowing': false,
      'authorAvatar': 'https://randomuser.me/api/portraits/women/68.jpg',
    },
    {
      'author': 'design.pro',
      'description': 'Criando uma interface do zero no Figma - parte 1: wireframes e prototipagem #ux #ui #design',
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
    _tabController = TabController(length: 2, vsync: this);
    
    // Definir orientação para portrait somente
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    // Ocultar a barra de status e navegação
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    
    // Restaurar orientações e barras do sistema
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _isLiked = false;
      _isBookmarked = false;
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    
    // Aqui adicionaríamos a lógica para atualizar o contador de likes no backend
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCommentsSheet(),
    );
  }

  Widget _buildCommentsSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Barra de arraste
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Título da seção
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Comentários',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // Lista de comentários
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: 15, // Número simulado de comentários
                  itemBuilder: (context, index) {
                    return _buildCommentItem();
                  },
                ),
              ),
              
              // Campo de comentário
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Adicione um comentário...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: AppTheme.primaryPurple,
                      radius: 20,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar do usuário
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
          ),
          const SizedBox(width: 12),
          
          // Conteúdo do comentário
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome do usuário e timestamp
                Row(
                  children: [
                    const Text(
                      'username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '2h',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                
                // Texto do comentário
                const Text(
                  'Este conteúdo é incrível! Adorei as dicas e já estou aplicando no meu dia-a-dia. Continue com o ótimo trabalho!',
                  style: TextStyle(fontSize: 14),
                ),
                
                // Likes e resposta
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Text(
                        'Curtir',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Responder',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Botão de curtir
          Column(
            children: [
              const Icon(
                Icons.favorite_border,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                '42',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'Seguindo'),
            Tab(text: 'Para Você'),
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
          
          return TikTokVideoItem(
            author: video['author'],
            description: video['description'],
            music: video['music'],
            likes: video['likes'],
            comments: video['comments'],
            shares: video['shares'],
            isFollowing: video['isFollowing'],
            authorAvatar: video['authorAvatar'],
            isLiked: _isLiked,
            isBookmarked: _isBookmarked,
            onLike: _toggleLike,
            onBookmark: _toggleBookmark,
            onComment: _showComments,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24),
            label: 'Descobrir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, size: 24),
            label: 'Caixa de entrada',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 24),
            label: 'Perfil',
          ),
        ],
        currentIndex: 0,
      ),
    );
  }
}

class TikTokVideoItem extends StatelessWidget {
  final String author;
  final String authorAvatar;
  final String description;
  final String music;
  final String likes;
  final String comments;
  final String shares;
  final bool isFollowing;
  final bool isLiked;
  final bool isBookmarked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onBookmark;

  const TikTokVideoItem({
    Key? key,
    required this.author,
    required this.description,
    required this.music,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isFollowing,
    required this.authorAvatar,
    required this.isLiked,
    required this.isBookmarked,
    required this.onLike,
    required this.onComment,
    required this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Camada de vídeo (simulada com cor de fundo)
        Container(
          color: Colors.black,
          child: Center(
            child: Image.network(
              'https://source.unsplash.com/random/1080x1920/?tech,coding',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.videocam_off,
                    color: Colors.white54,
                    size: 60,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),
        ),
        
        // Gradiente para melhorar a legibilidade do texto
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        
        // Controles e informações sobrepostas
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Espaço expandido para tap para pausar/reproduzir
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Pausa/reproduz vídeo
                },
                onDoubleTap: onLike,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            
            // Rodapé com informações e controles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Lado esquerdo (informações do autor, descrição, música)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome do autor com botão de seguir
                        Row(
                          children: [
                            Text(
                              '@$author',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isFollowing)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Seguir',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        // Descrição do vídeo
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        
                        // Informação da música
                        Row(
                          children: [
                            const Icon(
                              Icons.music_note,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                music,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  
                  // Lado direito (botões de interação)
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        // Avatar do autor
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  authorAvatar,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryPurple,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Botão de curtir
                        _buildSideButton(
                          icon: isLiked ? Icons.favorite : Icons.favorite_border,
                          label: likes,
                          color: isLiked ? Colors.red : Colors.white,
                          onTap: onLike,
                        ),
                        const SizedBox(height: 14),
                        
                        // Botão de comentários
                        _buildSideButton(
                          icon: Icons.comment,
                          label: comments,
                          onTap: onComment,
                        ),
                        const SizedBox(height: 14),
                        
                        // Botão de favoritos
                        _buildSideButton(
                          icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          label: 'Salvar',
                          color: isBookmarked ? AppTheme.primaryPurple : Colors.white,
                          onTap: onBookmark,
                        ),
                        const SizedBox(height: 14),
                        
                        // Botão de compartilhar
                        _buildSideButton(
                          icon: Icons.reply,
                          label: shares,
                          onTap: () {},
                          flipIcon: true,
                        ),
                        const SizedBox(height: 12),
                        
                        // Disco de música rotativo
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                            image: DecorationImage(
                              image: NetworkImage(authorAvatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSideButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
    bool flipIcon = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: flipIcon ? Matrix4.rotationY(3.14) : Matrix4.identity(),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 