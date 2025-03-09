import 'package:flutter/material.dart';

class UserTile2 extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile2({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Icon
            Icon(Icons.person),
            // Users Name
            Expanded(child: Text(text, maxLines: 1)),
          ],
        ),
      ),
    );
  }
}
