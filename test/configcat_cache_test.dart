import 'dart:convert';

import 'package:configcat_preferences_cache/configcat_preferences_cache.dart';
import 'package:configcat_client/configcat_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_adapter.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Cache Tests', () {
    test('integration', () async {
      final config =
          '{"keyBool":{"t":0,"v":{"b":true},"i":"eddc7af8"},"keyDouble":{"t":3,"v":{"d":120.121238476},"i":"675817ef"},"keyInteger":{"t":2,"v":{"i":1248},"i":"dd641a2c"},"keySampleText":{"t":1,"v":{"s":"This text came from ConfigCat"},"i":"eda16475"},"keyString":{"t":1,"v":{"s":"Lorem ipsum"},"i":"bc200774"}}';
      final body =
          '{"p":{"u":"https://cdn-global.configcat.com","r":0,"s":"ymHUctuvSUO23Jvy98MGFgUx3hDIuzUrxzfF3ntCLUk="},"f":$config}';
      final sdkKey = 'PKDVCLf-Hq-h-kCzMp-L7Q/PaDVCFk9EpmD6sLpGLltTA';
      final path =
          'https://cdn-global.configcat.com/configuration-files/$sdkKey/config_v6.json';
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();

      final client = ConfigCatClient.get(
          sdkKey: sdkKey,
          options: ConfigCatOptions(
              cache: ConfigCatPreferencesCache(),
              pollingMode: PollingMode.manualPoll()));

      final dioAdapter = HttpTestAdapter(client.httpClient);
      dioAdapter.enqueueResponse(path, 200, jsonDecode(body));

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
