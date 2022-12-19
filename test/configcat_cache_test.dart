import 'dart:convert';

import 'package:configcat_preferences_cache/configcat_preferences_cache.dart';
import 'package:configcat_client/configcat_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Cache Tests', () {
    test('integration', () async {
      final config =
          '{"keyBool":{"v":true,"t":0,"p":[],"r":[],"i":"eddc7af8"},"keyDouble":{"v":120.121238476,"t":3,"p":[],"r":[],"i":"675817ef"},"keyInteger":{"v":1248,"t":2,"p":[],"r":[],"i":"dd641a2c"},"keySampleText":{"v":"This text came from ConfigCat","t":1,"p":[],"r":[],"i":"eda16475"},"keyString":{"v":"Lorem ipsum","t":1,"p":[],"r":[],"i":"bc200774"}}}';
      final body =
          '{"p":{"u":"https://cdn-global.configcat.com","r":0},"f":$config';
      final sdkKey = 'PKDVCLf-Hq-h-kCzMp-L7Q/PaDVCFk9EpmD6sLpGLltTA';
      final path =
          'https://cdn-global.configcat.com/configuration-files/$sdkKey/config_v5.json';
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();

      final client = ConfigCatClient.get(
          sdkKey: sdkKey,
          options: ConfigCatOptions(
              cache: ConfigCatPreferencesCache(),
              pollingMode: PollingMode.manualPoll()));

      final dioAdapter = DioAdapter(dio: client.httpClient);
      dioAdapter.onGet(path, (server) {
        server.reply(200, jsonDecode(body));
      });

      await client.forceRefresh();

      final values = await client.getAllValues();
      expect(values.length, equals(5));

      final keys = sharedPreferences.getKeys();
      expect(keys.length, equals(1));

      final value = sharedPreferences.getString(keys.first);
      expect(value, contains(body));

      client.close();
    });
  });
}
