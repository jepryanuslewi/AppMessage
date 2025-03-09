import 'package:app_message/pages/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Function()? onTap;
  const MyDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            DrawerHeader(child: Icon(Icons.message_outlined, size: 64)),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              title: Text('H O M E'),
              leading: Icon(Icons.home_outlined, size: 30),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              title: Text('S E T T I N G'),
              leading: Icon(Icons.settings, size: 30),
            ),

            // Swith to dark mode
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10),
          child: ListTile(
            onTap: onTap,
            leading: Icon(Icons.logout, size: 25),
            title: Text('L O G O U T '),
          ),
        ),
      ],
    );
  }
}
