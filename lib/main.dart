// Import necessary packages and libraries
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

// Define a boolean variable to check if the onboarding screen has been shown
bool? shownOnBoard;

// Main function, called when the app starts
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set up an HttpOverrides instance to bypass certificate checks
  HttpOverrides.global = ChatHttpOverrides();

  // Initialize text-to-speech functionality
  TextToSpeech.initTTS();

  // Show the system status bar
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  // Load saved preferences
  SharedPreferences pref = await SharedPreferences.getInstance();

  // Get the value of 'ON_BOARDING' preference, if not found, use default value true
  shownOnBoard = pref.getBool('ON_BOARDING') ?? true;

  // Start the app
  runApp(const ChatApp());
}

// Root widget of the app
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap multiple ChangeNotifierProvider widgets with MultiProvider widget
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      // Define the MaterialApp widget
      child: MaterialApp(
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        // Set the app title
        title: 'iNet Africa Assistant',
        // Set the app theme
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor,
          ),
        ),
        // Define the app's routes
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

// HttpOverrides instance to bypass certificate checks
class ChatHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
