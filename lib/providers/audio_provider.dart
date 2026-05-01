import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentPlayingTitle = "";
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Timer? _sleepTimer;
  bool get isTimerActive => _sleepTimer != null && _sleepTimer!.isActive;

  // ඩවුන්ලෝඩ් වූ ෆයිල්ස් මතක තබා ගැනීම
  List<String> downloadedFiles = [];
  Map<String, double> downloadProgress = {}; // ඩවුන්ලෝඩ් වන ප්‍රතිශතය

  AudioProvider() {
    _checkDownloadedFiles(); // මුලින්ම ඩවුන්ලෝඩ් කරපු ඒවා තියෙනවද බලනවා

    audioPlayer.playerStateStream.listen((state) {
      isPlaying = state.playing;
      if (state.processingState == ProcessingState.completed) {
        isPlaying = false;
        position = Duration.zero;
        audioPlayer.seek(Duration.zero);
        audioPlayer.pause();
      }
      notifyListeners();
    });

    audioPlayer.durationStream.listen((newDuration) {
      duration = newDuration ?? Duration.zero;
      notifyListeners();
    });

    audioPlayer.positionStream.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });
  }

  // ෆෝන් එකේ සේව් වෙලා තියෙන ෆයිල්ස් හොයනවා
  Future<void> _checkDownloadedFiles() async {
    if (kIsWeb) return; // Chrome එකේ ටෙස්ට් කරද්දී මෙය වැඩ නොකරයි
    try {
      final dir = await getApplicationDocumentsDirectory();
      final files = dir.listSync();
      downloadedFiles = files.map((f) => f.path.split('/').last).toList();
      notifyListeners();
    } catch (e) {
      print("Error checking files: $e");
    }
  }

  // ෆයිල් එක ඩවුන්ලෝඩ් වෙලාද කියලා බලනවා
  bool isDownloaded(String url) {
    if (url.startsWith('assets/')) return true; // App එකේ එන ඒවා කොහොමත් offline
    if (kIsWeb) return false;
    final fileName = url.split('/').last;
    return downloadedFiles.contains(fileName);
  }

  // MP3 එක ඩවුන්ලෝඩ් කරන Function එක
  Future<void> downloadAudio(String url) async {
    if (kIsWeb || url.startsWith('assets/') || isDownloaded(url)) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final savePath = '${dir.path}/$fileName';

      downloadProgress[url] = 0.0;
      notifyListeners();

      final dio = Dio();
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          downloadProgress[url] = received / total;
          notifyListeners();
        }
      });

      downloadProgress.remove(url);
      downloadedFiles.add(fileName);
      notifyListeners();
    } catch (e) {
      downloadProgress.remove(url);
      notifyListeners();
      print("Download error: $e");
    }
  }

  // Play කිරීමේ Function එක අලුත් කිරීම
  void playAudio(String url, String title, [String author = "දේශකයන් වහන්සේ"]) async {
    try {
      if (currentPlayingTitle == title) {
        if (isPlaying) {
          await audioPlayer.pause();
        } else {
          await audioPlayer.play();
        }
      } else {
        currentPlayingTitle = title;
        isPlaying = false;
        notifyListeners();

        AudioSource audioSource;
        final mediaItem = MediaItem(
          id: url,
          album: "නිවන් මග Premium",
          title: title,
          artist: author,
          artUri: Uri.parse("Gemini_Generated_Image_7i1mlp7i1mlp7i1m.png"),
        );

        if (url.startsWith('assets/')) {
          // 1. App එක ඇතුළෙම තියෙන Offline බණක් නම්
          audioSource = AudioSource.asset(url, tag: mediaItem);
        } else if (isDownloaded(url) && !kIsWeb) {
          // 2. කලින් ඩවුන්ලෝඩ් කරපු Online බණක් නම් (Data කැපෙන්නේ නෑ)
          final dir = await getApplicationDocumentsDirectory();
          final fileName = url.split('/').last;
          final file = File('${dir.path}/$fileName');
          audioSource = AudioSource.uri(Uri.file(file.path), tag: mediaItem);
        } else {
          // 3. තාම ඩවුන්ලෝඩ් කරලා නැති Online බණක් නම් (Data වලින් ප්ලේ වෙයි)
          audioSource = AudioSource.uri(Uri.parse(url), tag: mediaItem);
        }

        await audioPlayer.setAudioSource(audioSource);
        await audioPlayer.play();
      }
    } catch (e) {
      print("Audio Play කිරීමේ ගැටලුවක්: $e");
    }
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  void resumeAudio() async {
    await audioPlayer.play();
  }

  void seekAudio(Duration positionToSeek) async {
    await audioPlayer.seek(positionToSeek);
  }

  void stopAudio() async {
    await audioPlayer.stop();
    isPlaying = false;
    currentPlayingTitle = "";
    position = Duration.zero;
    notifyListeners();
  }

  void setSleepTimer(Duration timerDuration) {
    _sleepTimer?.cancel();
    _sleepTimer = Timer(timerDuration, () {
      pauseAudio();
      _sleepTimer = null;
      notifyListeners();
    });
    notifyListeners();
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    notifyListeners();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _sleepTimer?.cancel();
    super.dispose();
  }
}