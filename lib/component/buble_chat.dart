import 'package:flutter/material.dart';

class BubleChat extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const BubleChat({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    print('BubleChat message: $message, isCurrentUser: $isCurrentUser');
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color:
            isCurrentUser
                ? Colors.teal.shade400
                : const Color.fromARGB(255, 248, 149, 144),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
