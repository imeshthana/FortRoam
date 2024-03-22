import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fort_roam/components/constants.dart';
import 'package:hive/hive.dart';

class FavPlaces {
  Box favBox = Hive.box('favBox');

  List<String> getFavoritePlaces() {
    return favBox.get('favPlaces') ?? [];
  }

  void addFavoritePlace(String place) {
    List<String> favPlaces = getFavoritePlaces();
    favPlaces.add(place);
    favBox.put('favPlaces', favPlaces);
  }

  void removeFavoritePlace(String place) {
    List<String> favPlaces = getFavoritePlaces();
    favPlaces.remove(place);
    favBox.put('favPlaces', favPlaces);
  }
}
