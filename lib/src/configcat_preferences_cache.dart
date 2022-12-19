import 'package:configcat_client/configcat_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ConfigCat Flutter Cache based on shared_preferences.
class ConfigCatPreferencesCache extends ConfigCatCache {
  @override
  Future<String> read(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<void> write(String key, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }
}
