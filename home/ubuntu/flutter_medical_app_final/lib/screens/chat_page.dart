import 'package:flutter/material.dart';
import 'dart:async';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<_ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(
        _ChatMessage(text: text, time: _getCurrentTime(), isUser: true),
      );
      _isTyping = true;
    });
    _controller.clear();
    // Simulate AI bot reply
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add(
          _ChatMessage(
            text: _getBotReply(text),
            time: _getCurrentTime(),
            isUser: false,
          ),
        );
        _isTyping = false;
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _getBotReply(String userText) {
    final text = userText.toLowerCase();
    if (text.contains('hello') || text.contains('hi')) {
      return "Hello! How can I assist you today?";
    }
    if (text.contains('appointment') || text.contains('book')) {
      return "Would you like to book a new appointment or check your upcoming ones?";
    }
    if (text.contains('thanks') || text.contains('thank you')) {
      return "You're welcome! If you have any more questions, feel free to ask.";
    }
    if (text.contains('problem') || text.contains('issue')) {
      return "I'm sorry to hear that. Can you please describe your problem in more detail?";
    }
    if (text.contains('medicine') || text.contains('prescription')) {
      return "Do you need information about your medication or a new prescription?";
    }
    if (text.contains('test result') || text.contains('lab')) {
      return "Would you like to review your latest test results?";
    }
    if (text.contains('bye') || text.contains('goodbye')) {
      return "Goodbye! Have a healthy day.";
    }
    return "Thank you for your message. I will get back to you soon.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00e0ef), Color(0xFF00c6ff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  backgroundImage: const NetworkImage(
                    'https://randomuser.me/api/portraits/women/44.jpg',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Dr. Emma Hall, M.D.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.call, color: Color(0xFF00c6ff)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.videocam, color: Color(0xFF00c6ff)),
                  onPressed: () {},
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          _buildQuickReplies(),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dr. Emma is typing...',
                  style: TextStyle(
                    color: Color(0xFF00c6ff),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage msg) {
    final isUser = msg.isUser;
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(isUser ? 18 : 0),
      bottomRight: Radius.circular(isUser ? 0 : 18),
    );
    final bubbleColor = isUser ? Color(0xFFE9F7FE) : Colors.black;
    final borderColor = isUser ? Colors.transparent : Color(0xFF00e0ef);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 220),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  border: Border.all(color: borderColor, width: 1.2),
                  borderRadius: borderRadius,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  msg.text,
                  style: TextStyle(
                    color: isUser ? Colors.black : Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
            child: Text(
              msg.time,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFF00e0ef), width: 2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE9F7FE),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Write Here...',
                  border: InputBorder.none,
                ),
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.mic, color: Color(0xFF00c6ff)),
            onPressed: () {},
          ),
          SizedBox(width: 4),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF00e0ef), Color(0xFF00c6ff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () => _sendMessage(_controller.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    final List<String> quickReplies = [
      'Hello',
      'Appointment',
      'Thanks',
      'Problem',
      'Medicine',
      'Test Result',
      'Bye',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: quickReplies.map((text) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE9F7FE),
                  foregroundColor: Color(0xFF00c6ff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _sendMessage(text),
                child: Text(text),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final String time;
  final bool isUser;
  _ChatMessage({required this.text, required this.time, required this.isUser});
}
