import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class Preferences {
  Future<void> setSearchHistory(String searchHistory) async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString(_searchHistory, searchHistory);
  }

  Future<String> getSearchHistory() async {
    var prefs = await SharedPreferences.getInstance();
    var searchHistory = prefs.getString(_searchHistory);

    if (searchHistory != null) {
      return searchHistory;
    }

    return '';
  }

  static const String _searchHistory = 'search_history';
}
