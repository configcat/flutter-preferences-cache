import 'package:configcat_cache/configcat_cache.dart';
import 'package:configcat_client/configcat_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group('Cache Tests', () {
    test('integration', () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();

      final client = ConfigCatClient.get(
          sdkKey: "PKDVCLf-Hq-h-kCzMp-L7Q/PaDVCFk9EpmD6sLpGLltTA",
          options: ConfigCatOptions(cache: ConfigCatPreferencesCache()));

      final values = await client.getAllValues();
      final keys = sharedPreferences.getKeys();
      final value = sharedPreferences.getString(keys.first);

      expect(values.length, equals(5));
      expect(keys.length, equals(1));
      expect(
          value,
          startsWith(
              '{"config":{"p":{"u":"https://cdn-global.configcat.com","r":0},"f":{"keyBool":{"v":true,"t":0,"p":[],"r":[],"i":"eddc7af8"}'));
    });
  });
}
