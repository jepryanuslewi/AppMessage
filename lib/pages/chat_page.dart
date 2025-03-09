import 'package:app_message/component/buble_chat.dart';
import 'package:app_message/component/my_text_field.dart';
import 'package:app_message/services/auth/auth_service.dart';
import 'package:app_message/services/message/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiveEmail, required this.receiverId});

  // Text Controller
  final TextEditingController _messageController = TextEditingController();

  // Chat and Auth Service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //  send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(receiverId, _messageController.text);

      // Clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          receiveEmail,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          // display all message
          Expanded(child: _buildMessageList()),
          // user input
          _buildMessageInput(context),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        // check if snapshot has data
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No messages');
        }

        // return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // debug print
    print('message data: $data');

    // is current user
    bool isCurrentUser = data["senderId"] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,

      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          BubleChat(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  // Build message Input
  Widget _buildMessageInput(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.emoji_emotions_outlined, size: 35),
          ),
          // textfield should take up most of the space
          Expanded(
            child: MyTextField(controller: _messageController, text: 'Message'),
          ),
          // Icons Send Button
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
