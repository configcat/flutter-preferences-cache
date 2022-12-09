# ConfigCat Flutter Cache

[![pub package](https://img.shields.io/pub/v/configcat_cache.svg)](https://pub.dev/packages/configcat_cache)
[![Dart CI](https://github.com/configcat/flutter-cache/actions/workflows/flutter-cache-ci.yml/badge.svg?branch=main)](https://github.com/configcat/flutter-cache/actions/workflows/flutter-cache-ci.yml)

https://configcat.com

Cache implementation for [ConfigCat Dart (Flutter) SDK](https://configcat.com/docs/sdk-reference/dart/) based on [shared_preferences](https://pub.dev/packages/shared_preferences).

ConfigCat is a feature flag and configuration management service that lets you separate feature releases from code deployments. You can turn features ON or OFF using the <a href="https://app.configcat.com" target="_blank">ConfigCat Dashboard</a> even after they are deployed. ConfigCat lets you target specific groups of users based on region, email, or any other custom user attribute.

ConfigCat is a <a href="https://configcat.com" target="_blank">hosted feature flag service</a> that lets you manage feature toggles across frontend, backend, mobile, and desktop apps. <a href="https://configcat.com" target="_blank">Alternative to LaunchDarkly</a>. Management app + feature flag SDKs.

## Getting started

### 1. Install the package along with the [ConfigCat Dart (Flutter) SDK](https://configcat.com/docs/sdk-reference/dart/)
```bash
flutter pub add configcat_cache
flutter pub add configcat_client
```

### 2. Import the *configcat_client* and *configcat_cache* package in your application code
```dart
import 'package:configcat_client/configcat_client.dart';
import 'package:configcat_cache/configcat_cache.dart';
```

### 3. Use `ConfigCatPreferencesCache` at the ConfigCat SDK's initialization
```dart
final client = ConfigCatClient.get(
    sdkKey: '#YOUR-SDK-KEY#',
    options: ConfigCatOptions(cache: ConfigCatPreferencesCache()));
```

## Support
If you need help using this SDK, feel free to contact the ConfigCat Staff at [https://configcat.com](https://configcat.com). We're happy to help.

## Contributing
Contributions are welcome. For more info please read the [Contribution Guideline](CONTRIBUTING.md).

## About ConfigCat
- [Official ConfigCat SDKs for other platforms](https://github.com/configcat)
- [Documentation](https://configcat.com/docs)
- [Blog](https://configcat.com/blog)