import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio_background/just_audio_background.dart';

// --- අලුතින් හදපු Splash Screen එක Import කරමු ---
import 'screens/splash_screen.dart'; 
import 'providers/audio_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/favorites_provider.dart';

Future<void> main() async {
  // ෆෝන් එකේ සිස්ටම් එකත් එක්ක සම්බන්ධ වීමට අවශ්‍ය අනිවාර්ය කේතය (සුදු තිරය මඟ හරවයි)
  WidgetsFlutterBinding.ensureInitialized();

  // App එක Run වීමට පෙර Background Audio සක්‍රිය කිරීම
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.charitheranda.niwanmaga.audio', 
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const NiwanMagaApp(),
    ),
  );
}

class NiwanMagaApp extends StatelessWidget {
  const NiwanMagaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'නිවන් මග',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light, 
        fontFamily: 'Segoe UI', 
        useMaterial3: true
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, 
        fontFamily: 'Segoe UI', 
        useMaterial3: true, 
        scaffoldBackgroundColor: const Color(0xFF0B0F19)
      ),
      
      // --- වෙනස් කළ තැන: මුලින්ම පෙන්වන්නේ Splash Screen එකයි ---
      home: const SplashScreen(),
    );
  }
}