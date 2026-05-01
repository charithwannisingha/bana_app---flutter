import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/global_player.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider එක හරහා තෝරාගත් බණ ලැයිස්තුව ලබාගැනීම
    final favProvider = Provider.of<FavoritesProvider>(context);
    final audioProvider = Provider.of<AudioProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final tracks = favProvider.favoriteTracks;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white70 : const Color(0xFF5D4037)),
        title: Text("කැමතිම දේවල්", style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF5D4037), fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF0B1021), const Color(0xFF1B1B2F), const Color(0xFF2B2B4A)]
                    : [const Color(0xFFFFF0DC), const Color(0xFFF0FAFA), const Color(0xFFE6E6FA)],
              ),
            ),
          ),
          SafeArea(
            child: tracks.isEmpty
                ? Center(child: Text("තවම කැමතිම ගොනු එකතු කර නොමැත.", style: TextStyle(fontSize: 16, color: isDark ? Colors.white54 : Colors.black54)))
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];
                      final isSelected = audioProvider.currentPlayingTitle == track.title;

                      return Card(
                        color: isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.6),
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isSelected ? Colors.orange.shade300 : (isDark ? Colors.white24 : Colors.brown.shade200),
                            child: Icon(isSelected && audioProvider.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                          ),
                          title: Text(track.title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                          subtitle: Text(track.author, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                          
                          // මේ ලැයිස්තුවෙන් අයින් කරන්නත් බොත්තමක් දෙනවා
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                            onPressed: () {
                              favProvider.toggleFavorite(track);
                            },
                          ),
                          onTap: () {
                            audioProvider.playAudio(track.url, track.title);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // යටින් අපේ Global Player එක පෙන්නනවා
      bottomNavigationBar: const GlobalPlayer(),
    );
  }
}