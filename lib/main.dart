import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatbot/utils/constants/constants.dart';
import 'package:chatbot/ui/screens/text_chat.dart';
import 'package:chatbot/ui/screens/gallery.dart';
import 'package:chatbot/ui/screens/splash_screen.dart';
import 'package:chatbot/data/providers/chats_provider.dart';
import 'package:chatbot/data/providers/models_provider.dart';
import 'package:chatbot/ui/screens/developer.dart';
import 'package:chatbot/ui/screens/home_page.dart';
import 'services/textspeech_tts.dart';
import 'package:chatbot/ui/screens/image_creater.dart';
import 'package:chatbot/ui/screens/voice_chat.dart';
import 'package:chatbot/ui/widgets/drawer_widget.dart';

bool? shownOnBoard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = ChatHttpOverrides();
  TextToSpeech.initTTS();

  // to show status bar
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  SharedPreferences pref = await SharedPreferences.getInstance();
  shownOnBoard = pref.getBool('ON_BOARDING') ?? true;

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iNet Africa Assistant',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor,
          ),
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          DeveloperInfo.routeName: (_) => const DeveloperInfo(),
          MainDrawer.routeName: (_) => const MainDrawer(),
          HomePage.routeName: (_) => const HomePage(),
          ImageGenerator.routeName: (_) => const ImageGenerator(),
          ChatScreen.routeName: (_) => const ChatScreen(),
          VoiceChatBot.routeName: (_) => const VoiceChatBot(),
          Gallery.routeName: (_) => const Gallery(),
        },
      ),
    );
  }
}

class ChatHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
