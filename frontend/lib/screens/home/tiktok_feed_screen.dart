import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../widgets/bottom_nav_bar.dart';

class TikTokFeedScreen extends StatefulWidget {
  const TikTokFeedScreen({Key? key}) : super(key: key);

  @override
  State<TikTokFeedScreen> createState() => _TikTokFeedScreenState();
}

class _TikTokFeedScreenState extends State<TikTokFeedScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  int _currentVideoIndex = 0;

  // Lista de vídeos mock
  final List<Map<String, dynamic>> _videos = [
    {
      'videoUrl': kIsWeb
          ? 'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
          : 'assets/videos/vidio1.mp4',
      'authorName': 'ana.dev',
      'authorAvatar': 'assets/images/profiles/2.jpg',
      'description': 'Meu primeiro vídeo no TikTok! #flutter #dev',
      'likes': 1234,
      'comments': 89,
      'shares': 45,
      'music': 'Música Original - ana.dev',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'videoUrl': kIsWeb
          ? 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'
          : 'assets/videos/vidio2.mp4',
      'authorName': 'joao.dev',
      'authorAvatar': 'assets/images/profiles/1.jpg',
      'description': 'Coding in Flutter is amazing! 🚀 #flutter #coding',
      'likes': 5678,
      'comments': 234,
      'shares': 123,
      'music': 'Música Original - joao.dev',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'videoUrl': kIsWeb
          ? 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'
          : 'assets/videos/vidio3.mp4',
      'authorName': 'maria.tech',
      'authorAvatar': 'assets/images/profiles/3.jpg',
      'description': 'Aprendendo Flutter! 💻 #programação #mobile',
      'likes': 3456,
      'comments': 167,
      'shares': 89,
      'music': 'Música Original - maria.tech',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'videoUrl': kIsWeb
          ? 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'
          : 'assets/videos/vidio4.mp4',
      'authorName': 'pedro.code',
      'authorAvatar': 'assets/images/profiles/4.jpg',
      'description': 'Dicas de Flutter para iniciantes! 🎯 #flutter #dicas',
      'likes': 7890,
      'comments': 456,
      'shares': 234,
      'music': 'Música Original - pedro.code',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'videoUrl': kIsWeb
          ? 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4'
          : 'assets/videos/vidio5.mp4',
      'authorName': 'lucia.dev',
      'authorAvatar': 'assets/images/profiles/5.jpg',
      'description': 'Meu app em Flutter! 📱 #mobile #app',
      'likes': 4321,
      'comments': 289,
      'shares': 156,
      'music': 'Música Original - lucia.dev',
      'isLiked': false,
      'isSaved': false,
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
    // Pausar o vídeo atual antes de desmontar a tela
    setState(() {
      _currentVideoIndex = -1; // Forçar a pausa de todos os vídeos
    });

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

  void _onNavTap(int index) {
    // Pausar o vídeo quando recebido o valor -1 (botão Criar)
    if (index == -1) {
      setState(() {
        _currentVideoIndex = -1; // Forçar a pausa de todos os vídeos
      });
      return;
    }

    // Garantir que o índice seja válido
    if (index < 0 || index > 3) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // Pausar o vídeo atual antes de navegar
    if (index != 0) {
      // Se não for a tela de feed
      // Forçar o vídeo atual a pausar
      setState(() {
        _currentVideoIndex =
            -1; // Definir um índice inválido para forçar a pausa
      });
    }

    // Navegar para as diferentes telas
    switch (index) {
      case 0: // Início - já estamos na tela TikTok
        break;
      case 2: // Mensagens
        Navigator.pushNamed(context, '/messages');
        break;
      case 3: // Perfil
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentVideoIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return TikTokVideoPlayer(
            videoUrl: _videos[index]['videoUrl'],
            authorName: _videos[index]['authorName'],
            authorAvatar: _videos[index]['authorAvatar'],
            description: _videos[index]['description'],
            likes: _videos[index]['likes'],
            comments: _videos[index]['comments'],
            shares: _videos[index]['shares'],
            music: _videos[index]['music'],
            isLiked: _videos[index]['isLiked'],
            isSaved: _videos[index]['isSaved'],
            onLike: () {
              setState(() {
                _videos[index]['isLiked'] = !_videos[index]['isLiked'];
                _videos[index]['likes'] += _videos[index]['isLiked'] ? 1 : -1;
              });
            },
            onSave: () {
              setState(() {
                _videos[index]['isSaved'] = !_videos[index]['isSaved'];
              });
            },
            isCurrentVideo: index == _currentVideoIndex,
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class TikTokVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String authorName;
  final String authorAvatar;
  final String description;
  final int likes;
  final int comments;
  final int shares;
  final String music;
  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final bool isCurrentVideo;

  const TikTokVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.authorName,
    required this.authorAvatar,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.music,
    required this.isLiked,
    required this.isSaved,
    required this.onLike,
    required this.onSave,
    required this.isCurrentVideo,
  }) : super(key: key);

  @override
  State<TikTokVideoPlayer> createState() => _TikTokVideoPlayerState();
}

class _TikTokVideoPlayerState extends State<TikTokVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _isInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(TikTokVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Se mudou o status de vídeo atual ou se não for mais o vídeo atual
    if (widget.isCurrentVideo != oldWidget.isCurrentVideo) {
      if (widget.isCurrentVideo) {
        _controller.play();
        _controller.setVolume(1.0);
        setState(() {
          _isPlaying = true;
        });
      } else {
        _controller.pause();
        _controller.setVolume(0.0);
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  Future<void> _initializeVideo() async {
    try {
      if (kIsWeb) {
        _controller = VideoPlayerController.network(widget.videoUrl);
      } else {
        _controller = VideoPlayerController.asset(widget.videoUrl);
      }

      _controller.addListener(() {
        final error = _controller.value.errorDescription;
        if (error != null && mounted) {
          setState(() {
            _error = error;
            print('Erro no player: $error');
          });
        }
      });

      await _controller.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _error = null;
        });

        if (widget.isCurrentVideo) {
          _controller.play();
          _controller.setVolume(1.0);
        } else {
          _controller.pause();
          _controller.setVolume(0.0);
        }

        _controller.setLooping(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          print('Erro ao carregar vídeo: $e');
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!_isInitialized || !widget.isCurrentVideo) return;
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.play();
        _controller.setVolume(1.0);
      } else {
        _controller.pause();
        _controller.setVolume(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Container preto de fundo
        Container(color: Colors.black),

        // Vídeo ou mensagem de erro
        GestureDetector(
          onTap: _togglePlay,
          child: _isInitialized
              ? Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    if (!_isPlaying)
                      const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 80,
                          color: Colors.white54,
                        ),
                      ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_error != null) ...[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Erro ao carregar o vídeo:\n$_error',
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _initializeVideo,
                          child: const Text('Tentar novamente'),
                        ),
                      ] else
                        const CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
                ),
        ),
        // Overlay com informações
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withAlpha(178)],
            ),
          ),
        ),
        // Informações do vídeo
        Positioned(
          bottom: 80,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome do autor e botão de seguir
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(widget.authorAvatar),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '@${widget.authorName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Seguir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Descrição
              Text(
                widget.description,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              // Música
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    widget.music,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Botões de interação
        Positioned(
          right: 16,
          bottom: 80,
          child: Column(
            children: [
              // Botão de curtir
              GestureDetector(
                onTap: widget.onLike,
                child: Column(
                  children: [
                    Icon(
                      widget.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: widget.isLiked ? Colors.red : Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.likes}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Botão de salvar
              GestureDetector(
                onTap: widget.onSave,
                child: Column(
                  children: [
                    Icon(
                      widget.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: widget.isSaved ? Colors.white : Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
