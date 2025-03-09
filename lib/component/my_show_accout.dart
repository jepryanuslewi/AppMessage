import 'package:app_message/component/user_tile_2.dart';
import 'package:app_message/pages/chat_page.dart';
import 'package:app_message/services/auth/auth_service.dart';
import 'package:app_message/services/message/chat_service.dart';
import 'package:flutter/material.dart';

class MyShowAccout extends StatefulWidget {
  const MyShowAccout({super.key});

  @override
  State<MyShowAccout> createState() => _MyShowAccoutState();
}

class _MyShowAccoutState extends State<MyShowAccout> {
  // Chat And Auth service
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 75),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('My Contact'),
          Expanded(child: _buildUserList()),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_sharp),
          ),
        ],
      ),
    );
  }

  // Build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return const Text('Error');
        }

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Return List View
        return ListView(
          children:
              snapshot.data!
                  .map<Widget>(
                    (userData) => _buildUserListItem(userData, context),
                  )
                  .toList(),
        );
      },
    );
  }

  // Build Individual List tile for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // Display all user except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile2(
        text: userData["email"],
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ChatPage(
                      receiveEmail: userData["email"],
                      receiverId: userData["uid"],
                    ),
              ),
            ),
      );
    } else {
      return Container();
    }
  }
}
