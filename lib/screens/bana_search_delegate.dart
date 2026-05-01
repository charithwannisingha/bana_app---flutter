import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/bana_data.dart';
import '../providers/audio_provider.dart';
import '../providers/favorites_provider.dart';

class BanaSearchDelegate extends SearchDelegate {
  // App එකේ තියෙන ඔක්කොම බණ එකම ලැයිස්තුවකට ගැනීම
  final List<BanaTrack> allTracks = categoryData.values.expand((tracks) => tracks).toList();

  // Search Bar එකේ අකුරු වල පාට සහ හැඩය
  @override
  ThemeData appBarTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFFF0DC),
        iconTheme: IconThemeData(color: isDark ? Colors.white70 : const Color(0xFF5D4037)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
        border: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 18),
      ),
    );
  }

  // සෙවුම් තීරුවේ පෙන්වන වචනය
  @override
  String get searchFieldLabel => "බණ, පිරිත් හෝ දේශකයන් සොයන්න...";

  // Search Bar එක අග තියෙන 'X' (මකන) බොත්තම
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // අකුරු මැකීම
        },
      )
    ];
  }

  // Search Bar එක මුල තියෙන 'Back' (පසුපසට යන) බොත්තම
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Search එකෙන් පිටවීම
      },
    );
  }

  // සෙවූ පසු එන ප්‍රතිඵල (Results)
  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  // අකුරු ටයිප් කරද්දී එන යෝජනා (Suggestions)
  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  // ප්‍රතිඵල ලැයිස්තුව පෙන්වන කොටස
  Widget _buildSearchResults(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final favProvider = Provider.of<FavoritesProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ටයිප් කරන අකුරු වලට ගැළපෙන බණ හෝ දේශකයන්ගේ නම් ෆිල්ටර් කිරීම
    final results = allTracks.where((track) {
      final titleMatch = track.title.toLowerCase().contains(query.toLowerCase());
      final authorMatch = track.author.toLowerCase().contains(query.toLowerCase());
      return titleMatch || authorMatch;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF0B1021), const Color(0xFF1B1B2F), const Color(0xFF2B2B4A)]
              : [const Color(0xFFFFF0DC), const Color(0xFFF0FAFA), const Color(0xFFE6E6FA)],
        ),
      ),
      child: results.isEmpty
          ? Center(child: Text("ප්‍රතිඵල කිසිවක් හමුවූයේ නැත.", style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100), // Player එකට ඉඩ තැබීම
              itemCount: results.length,
              itemBuilder: (context, index) {
                final track = results[index];
                final isSelected = audioProvider.currentPlayingTitle == track.title;
                final isFav = favProvider.isFavorite(track);

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
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isFav ? Colors.redAccent : (isDark ? Colors.white54 : Colors.grey),
                      ),
                      onPressed: () => favProvider.toggleFavorite(track),
                    ),
                    onTap: () => audioProvider.playAudio(track.url, track.title),
                  ),
                );
              },
            ),
    );
  }
}