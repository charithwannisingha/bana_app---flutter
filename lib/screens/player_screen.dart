import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../data/bana_data.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // දේශකයන් වහන්සේගේ නම ලබාගැනීම
    String currentAuthor = "දේශකයන් වහන්සේ";
    for (var tracks in categoryData.values) {
      for (var track in tracks) {
        if (track.title == audioProvider.currentPlayingTitle) {
          currentAuthor = track.author;
          break;
        }
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark ? [const Color(0xFF1B1B2F), const Color(0xFF0B1021)] : [const Color(0xFFFAF8F5), const Color(0xFFE6DED5)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 35),
                      color: isDark ? Colors.white70 : const Color(0xFF5D4037),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text("දැන් වාදනය වේ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white54 : Colors.black54)),
                    const SizedBox(width: 35),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // --- පින්තූරය පෙන්වන කොටස ---
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: isDark ? Colors.black54 : Colors.black26, blurRadius: 25, offset: const Offset(0, 15))],
                  image: const DecorationImage(
                    // මෙන්න මෙතන තමයි Offline පින්තූරය ගත්තේ
                    image: AssetImage("assets/images/cover.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text(audioProvider.currentPlayingTitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: isDark ? Colors.white : const Color(0xFF3B2416))),
                    const SizedBox(height: 8),
                    Text(currentAuthor, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: isDark ? Colors.white54 : const Color(0xFF8D6E63))),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        activeTrackColor: Colors.orange.shade400,
                        inactiveTrackColor: isDark ? Colors.white24 : Colors.orange.shade100,
                        thumbColor: Colors.orange.shade400,
                      ),
                      child: Slider(
                        min: 0,
                        max: audioProvider.duration.inSeconds.toDouble() > 0 ? audioProvider.duration.inSeconds.toDouble() : 1,
                        value: audioProvider.position.inSeconds.toDouble().clamp(0, audioProvider.duration.inSeconds.toDouble()),
                        onChanged: (value) => audioProvider.seekAudio(Duration(seconds: value.toInt())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatTime(audioProvider.position), style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(_formatTime(audioProvider.duration), style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 45,
                    color: isDark ? Colors.white70 : const Color(0xFF5D4037),
                    icon: const Icon(Icons.replay_10_rounded),
                    onPressed: () {
                      final newPos = audioProvider.position - const Duration(seconds: 10);
                      audioProvider.seekAudio(newPos.isNegative ? Duration.zero : newPos);
                    },
                  ),
                  const SizedBox(width: 25),
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.orange.shade400.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: IconButton(
                      iconSize: 50,
                      color: Colors.white,
                      icon: Icon(audioProvider.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                      onPressed: () {
                        audioProvider.isPlaying ? audioProvider.pauseAudio() : audioProvider.resumeAudio();
                      },
                    ),
                  ),
                  const SizedBox(width: 25),
                  IconButton(
                    iconSize: 45,
                    color: isDark ? Colors.white70 : const Color(0xFF5D4037),
                    icon: const Icon(Icons.forward_10_rounded),
                    onPressed: () => audioProvider.seekAudio(audioProvider.position + const Duration(seconds: 10)),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}