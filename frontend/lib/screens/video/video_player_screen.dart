import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String authorName;
  final String description;
  final int likes;
  final int comments;
  final int shares;

  const VideoPlayerScreen({
    Key? key,
    required this.videoUrl,
    required this.authorName,
    required this.description,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = true;
  bool _isLiked = false;
  bool _isFollowing = false;
  
  @override
  void initState() {
    super.initState();
    // Definir orientação para landscape ou portrait conforme necessário
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  
  @override
  void dispose() {
    // Restaurar orientações permitidas ao sair
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {
              // Mostrar menu de opções
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camada 1: Vídeo (simulado com uma imagem)
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              color: Colors.black,
              child: Center(
                child: Image.asset(
                  widget.videoUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: Icon(
                          Icons.video_file,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          // Camada 2: Ícone de Play/Pause no centro (quando pausado)
          if (!_isPlaying)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          
          // Camada 3: Barra de progresso na parte inferior
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 2,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                value: 0.5, // Valor simulado
                onChanged: (value) {
                  // Mudar posição do vídeo
                },
                activeColor: AppTheme.primaryPurple,
                inactiveColor: Colors.grey[700],
              ),
            ),
          ),
          
          // Camada 4: Informações e controles no lado direito
          Positioned(
            right: 16,
            bottom: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    IconButton(
                      onPressed: _toggleLike,
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : Colors.white,
                        size: 36,
                      ),
                    ),
                    Text(
                      '${widget.likes}',
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
                    IconButton(
                      onPressed: () {
                        // Abrir seção de comentários
                      },
                      icon: const Icon(
                        Icons.comment,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    Text(
                      '${widget.comments}',
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
                    IconButton(
                      onPressed: () {
                        // Abrir opções de compartilhamento
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    Text(
                      '${widget.shares}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Camada 5: Informações do autor e descrição na parte inferior
          Positioned(
            left: 16,
            right: 80,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '@${widget.authorName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _toggleFollow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFollowing ? Colors.grey : AppTheme.primaryPurple,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        _isFollowing ? 'Seguindo' : 'Seguir',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 