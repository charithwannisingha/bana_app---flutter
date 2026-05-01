import 'package:flutter/material.dart';
import '../data/bana_data.dart'; // BanaTrack එක මෙතනින් ලබා ගනී

class FavoritesProvider extends ChangeNotifier {
  final List<BanaTrack> _favoriteTracks = [];

  List<BanaTrack> get favoriteTracks => _favoriteTracks;

  // බණක් දැනටමත් කැමතිම ලැයිස්තුවේ තියෙනවද බැලීම
  bool isFavorite(BanaTrack track) {
    return _favoriteTracks.contains(track);
  }

  // හදවත එබූ විට ලැයිස්තුවට එකතු කිරීම හෝ ඉවත් කිරීම
  void toggleFavorite(BanaTrack track) {
    if (_favoriteTracks.contains(track)) {
      _favoriteTracks.remove(track);
    } else {
      _favoriteTracks.add(track);
    }
    notifyListeners();
  }
}