import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Animation එක පාලනය කරන විචල්‍යයන්
  double _opacity = 0.0;
  double _scale = 0.5;

  @override
  void initState() {
    super.initState();
    
    // App එක විවෘත වී මිලි තත්පර 100 කින් Animation එක පටන් ගනී
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _scale = 1.0;
        });
      }
    });

    // තත්පර 3 කට පසු ඉතා මෘදු ලෙස (Fade) Home Screen එකට යයි
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000), // තත්පරයකින් මාරු වේ
            pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0B0F19), const Color(0xFF151A29)]
                : [const Color(0xFFFAF8F5), const Color(0xFFE6DED5)],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 2), // තත්පර 2ක් පුරා මතු වේ
            opacity: _opacity,
            curve: Curves.easeIn,
            child: AnimatedScale(
              duration: const Duration(seconds: 2), // තත්පර 2ක් පුරා ලොකු වේ
              scale: _scale,
              curve: Curves.easeOutCubic,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // නෙළුම් මලේ සලකුණ
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.05) : Colors.orange.shade50,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black26 : Colors.orange.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ]
                    ),
                    child: Icon(
                      Icons.spa_rounded, // නෙළුම් මල
                      size: 70,
                      color: isDark ? Colors.orange.shade300 : const Color(0xFFD84315),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // මාතෘකාව
                  Text(
                    "නිවන් මග",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                      color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF3B2416),
                      shadows: [
                        Shadow(color: isDark ? Colors.black54 : Colors.brown.withOpacity(0.2), offset: const Offset(1, 2), blurRadius: 4)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // යටින් තියෙන වාක්‍යය
                  Text(
                    "ඔබේ සිත නිවන ධර්ම ශ්‍රවණයට...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white54 : const Color(0xFF8D6E63),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}