import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex =
      2; // Índice da tela de mensagens (era 3, agora é 2 após remover o botão "Para Você")

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      // Índice do item Perfil
      Navigator.pushNamed(context, '/profile');
    } else if (index == 0) {
      // Índice do item Início
      Navigator.pushNamed(context, '/tiktok');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista simulada de mensagens
    final List<Map<String, dynamic>> chats = [
      {
        'name': 'Ana Silva',
        'lastMessage': 'Adorei seu último vídeo! 😊',
        'time': '14:30',
        'avatar': 'assets/images/profiles/2.jpg',
        'unread': 2,
      },
      {
        'name': 'João Pedro',
        'lastMessage': 'Vamos gravar um vídeo juntos?',
        'time': '12:15',
        'avatar': 'assets/images/profiles/1.jpg',
        'unread': 0,
      },
      {
        'name': 'Maria Costa',
        'lastMessage': 'Obrigada por me seguir!',
        'time': 'Ontem',
        'avatar': 'assets/images/profiles/4.jpg',
        'unread': 1,
      },
      {
        'name': 'Carlos Santos',
        'lastMessage': 'Que legal seu conteúdo',
        'time': 'Ontem',
        'avatar': 'assets/images/profiles/3.jpg',
        'unread': 0,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mensagens',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implementar busca
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return InkWell(
            onTap: () {
              // Navegar para o chat individual
              _showChatDialog(context, chat);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(chat['avatar']),
                  ),
                  const SizedBox(width: 12),
                  // Informações da mensagem
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chat['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              chat['time'],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                chat['lastMessage'],
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (chat['unread'] > 0)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  chat['unread'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }

  void _showChatDialog(BuildContext context, Map<String, dynamic> chat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Cabeçalho do chat
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(chat['avatar']),
                ),
                const SizedBox(width: 12),
                Text(
                  chat['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            // Área de mensagens
            Expanded(
              child: ListView(
                reverse: true,
                children: [
                  _buildMessage(
                    'Olá! Como você está?',
                    false,
                    '14:30',
                  ),
                  _buildMessage(
                    'Oi! Estou bem, e você?',
                    true,
                    '14:31',
                  ),
                  _buildMessage(
                    chat['lastMessage'],
                    false,
                    chat['time'],
                  ),
                ],
              ),
            ),
            // Campo de entrada de mensagem
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Mensagem...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String message, bool isSent, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 250,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSent ? Colors.blue.shade100 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
                  isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(message),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
