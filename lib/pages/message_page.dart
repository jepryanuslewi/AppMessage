import 'package:app_message/component/my_drawer.dart';
import 'package:app_message/component/my_show_accout.dart';
import 'package:app_message/component/user_tile.dart';
import 'package:app_message/services/auth/auth_service.dart';
import 'package:app_message/services/message/chat_service.dart';
import 'chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  // Chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Log Out Method
  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // add new message with about alert
  void newMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MyShowAccout();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              "Chat App",
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onPressed: () => newMessage(context),
        child: Icon(
          Icons.message,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: Drawer(child: MyDrawer(onTap: logOut)),
      body: _buildUserList(),
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
      return UserTile(
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
