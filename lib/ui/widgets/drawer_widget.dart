import 'package:flutter/material.dart';

import '../screens/text_chat.dart';
import '../screens/developer.dart';
import '../screens/home_page.dart';
import '../screens/image_creater.dart';
import '../screens/gallery.dart';
import '../screens/voice_chat.dart';

class MainDrawer extends StatefulWidget {
  static const String routeName = '/main_drawer';
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFCCCCFF),
      child: ListView(
        children: [
          Container(
            height: 200,
            color: const Color(0xFF1E90FF),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(55),
                  child: Image.asset('assets/images/Next_Digit-Logo.png',
                      height: 110, width: 110, fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Personal Assistant",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const Text(
                  "info@inetafrica.com",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 4, 61, 107)),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomePage.routeName),
            leading: const Icon(
              Icons.dashboard,
            ),
            title: const Text('Home'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, ChatScreen.routeName),
            leading: const Icon(
              Icons.chat,
            ),
            title: const Text('Chat Assistant'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, VoiceChatBot.routeName),
            leading: const Icon(
              Icons.mic,
            ),
            title: const Text('Voice Assistant'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, ImageGenerator.routeName),
            leading: const Icon(
              Icons.add_photo_alternate_outlined,
            ),
            title: const Text('Creative Image Generator'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, Gallery.routeName),
            leading: const Icon(
              Icons.photo_library,
            ),
            title: const Text('My Art Gallery'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, DeveloperInfo.routeName),
            leading: const Icon(
              Icons.person,
            ),
            title: const Text('Developer Info'),
          ),
        ],
      ),
    );
  }
}
