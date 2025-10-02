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

  void addFavoritePlaceByIndex(int index, String place) {
    List<String> favPlaces = getFavoritePlaces();
    favPlaces.insert(index, place);
    favBox.put('favPlaces', favPlaces);
  }

  void removeFavoritePlace(String place) {
    List<String> favPlaces = getFavoritePlaces();
    favPlaces.remove(place);
    favBox.put('favPlaces', favPlaces);
  }

  void updateFavoritePlaces(List<String> places) {
  favBox.put('favPlaces', places);
  }
}
