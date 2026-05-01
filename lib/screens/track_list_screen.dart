import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Chrome ද කියා බැලීමට
import 'package:provider/provider.dart';
import '../data/bana_data.dart';
import '../providers/audio_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/global_player.dart';

class TrackListScreen extends StatelessWidget {
  final String categoryName;
  const TrackListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final tracks = categoryData[categoryName] ?? [];
    final audioProvider = Provider.of<AudioProvider>(context);
    final favProvider = Provider.of<FavoritesProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white70 : const Color(0xFF5D4037)),
        title: Text(
          categoryName, 
          style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF5D4037), fontWeight: FontWeight.bold)
        ),
      ),
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
            child: tracks.isEmpty
                ? Center(child: Text("තවම ශ්‍රව්‍ය ගොනු එකතු කර නොමැත.", style: TextStyle(fontSize: 16, color: isDark ? Colors.white54 : Colors.black54)))
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100), 
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];
                      final isSelected = audioProvider.currentPlayingTitle == track.title;
                      final isFav = favProvider.isFavorite(track);
                      
                      return Card(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.75),
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.6), width: 1.5),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isSelected 
                                ? Colors.orange.shade400 
                                : (isDark ? Colors.white24 : const Color(0xFFDDBEA9)),
                            child: Icon(isSelected && audioProvider.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                          ),
                          title: Text(
                            track.title, 
                            style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF2D1B14))
                          ),
                          subtitle: Text(
                            track.author,
                            style: TextStyle(color: isDark ? Colors.white54 : const Color(0xFF8D6E63))
                          ),
                          
                          // --- Heart බොත්තම සහ Download බොත්තම එකට ---
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Download බොත්තම / Progress / Tick එක
                              if (!kIsWeb) // Chrome එකේ ඩවුන්ලෝඩ් පෙන්වන්නේ නැත
                                Builder(builder: (context) {
                                  final isOfflineAsset = track.url.startsWith('assets/');
                                  final isDownloaded = audioProvider.isDownloaded(track.url);
                                  final isDownloading = audioProvider.downloadProgress.containsKey(track.url);
                                  
                                  if (isOfflineAsset || isDownloaded) {
                                    // Offline තියෙනවා නම් හරි (Tick) ලකුණ පෙන්වයි
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Icon(Icons.download_done_rounded, color: Colors.green),
                                    );
                                  } else if (isDownloading) {
                                    // ඩවුන්ලෝඩ් වෙමින් පවතී නම් කැරකෙන රවුම (Progress) පෙන්වයි
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: SizedBox(
                                        width: 24, height: 24,
                                        child: CircularProgressIndicator(
                                          value: audioProvider.downloadProgress[track.url],
                                          strokeWidth: 3,
                                          color: Colors.orange.shade400,
                                        ),
                                      ),
                                    );
                                  } else {
                                    // තාම ඩවුන්ලෝඩ් කරලා නැත්නම් Download අයිකන් එක
                                    return IconButton(
                                      icon: const Icon(Icons.download_rounded),
                                      color: isDark ? Colors.white54 : Colors.grey,
                                      onPressed: () => audioProvider.downloadAudio(track.url),
                                    );
                                  }
                                }),
                                
                              // Heart (Favorite) බොත්තම
                              IconButton(
                                icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                                  child: Icon(
                                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                    key: ValueKey<bool>(isFav),
                                  ),
                                ),
                                color: isFav ? Colors.redAccent : (isDark ? Colors.white54 : Colors.grey),
                                onPressed: () {
                                  favProvider.toggleFavorite(track);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            // මෙහි author ද එකතු කර ඇත
                            audioProvider.playAudio(track.url, track.title, track.author);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalPlayer(),
    );
  }
}