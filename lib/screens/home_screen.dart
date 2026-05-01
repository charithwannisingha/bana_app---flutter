import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // අලුතින් ගෙනා පැකේජය
import '../widgets/glass_card.dart';
import '../widgets/global_player.dart';
import '../providers/theme_provider.dart';
import 'track_list_screen.dart';
import 'favorites_screen.dart';
import 'bana_search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"title": "ධර්ම දේශනා", "icon": Icons.menu_book_rounded, "color": Color(0xFFDDBEA9)}, 
    {"title": "පිරිත්", "icon": Icons.library_music_rounded, "color": Color(0xFFFFB703)}, 
    {"title": "භාවනා", "icon": Icons.self_improvement_rounded, "color": Color(0xFF8ECAE6)}, 
    {"title": "බෝධි පූජා", "icon": Icons.nature_people_rounded, "color": Color(0xFFB7B7A4)}, 
    {"title": "කවි බණ", "icon": Icons.lyrics_rounded, "color": Color(0xFFF4A261)}, 
    {"title": "ජාතක කථා", "icon": Icons.auto_stories_rounded, "color": Color(0xFFE9C46A)}, 
    {"title": "සෙත් කවි", "icon": Icons.queue_music_rounded, "color": Color(0xFFA2D2FF)}, 
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [const Color(0xFF0B0F19), const Color(0xFF151A29)]
                    : [const Color(0xFFFAF8F5), const Color(0xFFF0EBE1)], 
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 30, 24, 4),
                      child: Text(
                        "නිවන් මග", 
                        style: TextStyle(
                          fontSize: 38, 
                          fontWeight: FontWeight.w900, 
                          letterSpacing: 1.2,
                          color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF3B2416),
                          shadows: [Shadow(color: isDark ? Colors.black87 : Colors.brown.withOpacity(0.15), offset: const Offset(1, 2), blurRadius: 3)],
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, right: 10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search_rounded),
                            color: isDark ? Colors.white70 : const Color(0xFF5D4037),
                            iconSize: 26,
                            onPressed: () => showSearch(context: context, delegate: BanaSearchDelegate()),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite_rounded),
                            color: Colors.redAccent.shade400,
                            iconSize: 26,
                            onPressed: () {
                              Navigator.push(context, PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, a, b) => const FavoritesScreen(),
                                transitionsBuilder: (context, a, b, child) => FadeTransition(opacity: a, child: child),
                              ));
                            },
                          ),
                          IconButton(
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) => RotationTransition(turns: animation, child: child),
                              child: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, key: ValueKey(isDark)),
                            ),
                            color: isDark ? Colors.amber.shade300 : const Color(0xFF5D4037),
                            iconSize: 26,
                            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline_rounded),
                            color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                            iconSize: 26,
                            onPressed: () => _showAboutApp(context, isDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "ඔබේ සිත නිවන ධර්ම ශ්‍රවණයට...", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isDark ? Colors.white54 : const Color(0xFF8D6E63))
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GlassCard(
                          title: cat["title"],
                          icon: cat["icon"],
                          color: cat["color"],
                          onTap: () {
                            Navigator.push(context, PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 400),
                              pageBuilder: (context, a, b) => TrackListScreen(categoryName: cat["title"]),
                              transitionsBuilder: (context, a, b, child) {
                                var tween = Tween(begin: const Offset(0.0, 0.05), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic));
                                return FadeTransition(opacity: a, child: SlideTransition(position: a.drive(tween), child: child));
                              },
                            ));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalPlayer(),
    );
  }

  // අලුතින් ගෙනා පැකේජයෙන් ලින්ක් එක විවෘත කිරීමේ ක්‍රමය
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  void _showAboutApp(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFFAF8F5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Column(
              children: [
                Icon(Icons.spa_rounded, size: 50, color: Colors.orange.shade400),
                const SizedBox(height: 10),
                Text("නිවන් මග", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                Text("Version 1.0.0", style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : Colors.black54)),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(color: isDark ? Colors.white24 : Colors.black12),
              const SizedBox(height: 10),
              Text("Designed & Developed by", style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black54)),
              const SizedBox(height: 5),
              Text("Charith Eranda", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: isDark ? Colors.white : const Color(0xFF3B2416))),
              const SizedBox(height: 20),
              
              // --- Clickable වෙබ් අඩවිය ---
              GestureDetector(
                onTap: () => _launchUrl('https://charitheranda.xyz'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language_rounded, size: 20, color: Colors.blue.shade400),
                    const SizedBox(width: 10),
                    Text(
                      "charitheranda.xyz", 
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.blue.shade400, 
                        fontWeight: FontWeight.bold,
                        // Click කරන්න පුළුවන් බව පෙන්වන්න යටින් ඉරක් ඇන්දා
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue.shade400,
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              
              // --- Clickable ඊමේල් ලිපිනය ---
              GestureDetector(
                onTap: () => _launchUrl('mailto:charitherandabs@gmail.com'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_rounded, size: 20, color: Colors.orange.shade400),
                    const SizedBox(width: 10),
                    Text(
                      "charitherandabs@gmail.com", 
                      style: TextStyle(
                        fontSize: 15, 
                        color: isDark ? Colors.white70 : Colors.black87,
                        decoration: TextDecoration.underline,
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("Close", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}