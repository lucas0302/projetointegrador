import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_button.dart';

class CreateVideoScreen extends StatefulWidget {
  const CreateVideoScreen({Key? key}) : super(key: key);

  @override
  State<CreateVideoScreen> createState() => _CreateVideoScreenState();
}

class _CreateVideoScreenState extends State<CreateVideoScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  VideoPlayerController? _controller;
  String _caption = '';
  bool _isLoading = false;
  bool _isRecording = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    if (_videoFile != null) {
      _controller = VideoPlayerController.file(_videoFile!);
      await _controller!.initialize();
      await _controller!.setLooping(true);
      await _controller!.play();
      setState(() {});
    }
  }

  Future<void> _recordVideo() async {
    setState(() {
      _isRecording = true;
    });

    try {
      // Especificamos explicitamente que queremos usar a câmera
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera, // Isso deve abrir a câmera, não a galeria
        maxDuration: const Duration(seconds: 60),
        preferredCameraDevice: CameraDevice.rear,
      );

      if (video != null) {
        setState(() {
        
          _videoFile = File(video.path);
          _controller?.dispose();
          _controller = null;
        });
        _initializeVideoPlayer();
      }
    } catch (e) {
      // Tratar erro de acesso à câmera
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao acessar a câmera: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      setState(() {
        _isRecording = false;
      });
    }
  }


  Future<void> _pickVideoFromGallery() async {
    try {
      // Garantir que estamos usando explicitamente a galeria
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery, // Especificamos a galeria
        maxDuration: const Duration(seconds: 60),
      );

      if (video != null) {
        setState(() {
          _videoFile = File(video.path);
          _controller?.dispose();
          _controller = null;
        });
        _initializeVideoPlayer();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao acessar a galeria: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _onRecordPressed() {
    if (!_isRecording) {
      _recordVideo();
    }
  }

  void _onGalleryPressed() {
    _pickVideoFromGallery();
  }

  void _onPublishPressed() {
    if (!_isLoading) {
      _uploadVideo();
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Aqui vai a implementação para enviar o vídeo para o backend
      await Future.delayed(const Duration(seconds: 2)); // Simulando upload

      if (mounted) {
        // Pausar o vídeo antes de sair
        _controller?.pause();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vídeo publicado com sucesso!')),
        );
        Navigator.pop(context, {'pauseVideos': true});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao publicar: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        // Liberar recursos de vídeo antes de sair
        _controller?.pause();

        // Ao voltar, retorna com um parâmetro para indicar que não deve reativar os vídeos automaticamente
        Navigator.pop(context, {'pauseVideos': true});
        return false; // Impede o comportamento padrão, pois já estamos tratando manualmente
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
              const Text('Criar vídeo', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              // Liberar recursos de vídeo antes de sair
              _controller?.pause();

              // Mesmo comportamento ao clicar no botão de fechar
              Navigator.pop(context, {'pauseVideos': true});
            },
          ),
          actions: [
            if (_videoFile != null)
              IconButton(
                icon: const Icon(Icons.check, color: Colors.white),
                onPressed: _isLoading ? null : () => _onPublishPressed(),
              ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: _videoFile == null
                  ? const Center(
                      child: Text(
                        'Grave um vídeo ou escolha da galeria',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : _controller != null && _controller!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        )
                      : const Center(child: CircularProgressIndicator()),
            ),
            if (_videoFile != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Adicione uma legenda...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    setState(() {
                      _caption = value;
                    });
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_videoFile == null) ...[
                    Expanded(
                      child: AppButton(
                        text: _isRecording ? 'Gravando...' : 'Gravar',
                        onPressed: _isRecording ? () {} : _onRecordPressed,
                        icon: Icons.videocam,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        text: 'Galeria',
                        onPressed: _onGalleryPressed,
                        icon: Icons.photo_library,
                        isOutlined: true,
                      ),
                    ),
                  ] else
                    Expanded(
                      child: AppButton(
                        text: _isLoading ? 'Publicando...' : 'Publicar',
                        onPressed: _isLoading ? () {} : _onPublishPressed,
                        icon: Icons.upload,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
