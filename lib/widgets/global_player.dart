import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../screens/player_screen.dart'; 

class GlobalPlayer extends StatelessWidget {
  const GlobalPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (audioProvider.currentPlayingTitle.isEmpty) {
      return const SizedBox.shrink();
    }

    double progress = 0.0;
    if (audioProvider.duration.inSeconds > 0) {
      progress = audioProvider.position.inSeconds / audioProvider.duration.inSeconds;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque, 
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => const PlayerScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic));
              return SlideTransition(position: animation.drive(tween), child: child);
            },
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 12), // දකුණු පැත්තේ padding එක ටිකක් අඩු කළා
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B).withOpacity(0.95) : Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.12), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("දැන් වාදනය වේ:", style: TextStyle(fontSize: 10, color: isDark ? Colors.white54 : Colors.black54)),
                        Text(
                          audioProvider.currentPlayingTitle,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => _showTimerOptions(context, audioProvider, isDark),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          child: Icon(
                            audioProvider.isTimerActive ? Icons.timer : Icons.timer_outlined,
                            size: 26,
                            color: audioProvider.isTimerActive ? Colors.orange.shade400 : (isDark ? Colors.white54 : Colors.black54),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (audioProvider.isPlaying) {
                            audioProvider.pauseAudio();
                          } else {
                            audioProvider.resumeAudio();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                            child: Icon(
                              audioProvider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                              key: ValueKey<bool>(audioProvider.isPlaying),
                              size: 42,
                              color: Colors.orange.shade400,
                            ),
                          ),
                        ),
                      ),
                      // --- අලුතින් එකතු කළ X (Close) බොත්තම ---
                      GestureDetector(
                        onTap: () {
                          audioProvider.stopAudio(); // X එබූ විට Audio එක නැවතී Player එක සැඟවී යයි
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          child: Icon(
                            Icons.close_rounded,
                            size: 26,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark ? Colors.white24 : Colors.orange.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade400),
                  minHeight: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimerOptions(BuildContext context, AudioProvider audioProvider, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ස්වයංක්‍රීයව නැවතීමේ කාලය", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 10),
              if (audioProvider.isTimerActive)
                ListTile(
                  leading: const Icon(Icons.cancel, color: Colors.redAccent),
                  title: const Text("කාලය අවලංගු කරන්න (Cancel)", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  onTap: () {
                    audioProvider.cancelSleepTimer();
                    Navigator.pop(context);
                  },
                ),
              _timerOption(context, audioProvider, isDark, "විනාඩි 15", const Duration(minutes: 15)),
              _timerOption(context, audioProvider, isDark, "විනාඩි 30", const Duration(minutes: 30)),
              _timerOption(context, audioProvider, isDark, "විනාඩි 45", const Duration(minutes: 45)),
              _timerOption(context, audioProvider, isDark, "පැය 1", const Duration(hours: 1)),
            ],
          ),
        );
      },
    );
  }

  Widget _timerOption(BuildContext context, AudioProvider audioProvider, bool isDark, String title, Duration duration) {
    return ListTile(
      leading: Icon(Icons.timer_outlined, color: isDark ? Colors.white70 : Colors.black54),
      title: Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
      onTap: () {
        audioProvider.setSleepTimer(duration);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$title කින් ප්ලේයරය ස්වයංක්‍රීයව නැවතිය හැක.", style: const TextStyle(fontFamily: 'Segoe UI')),
            backgroundColor: Colors.orange.shade400,
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}