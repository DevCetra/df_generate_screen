```dart
//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// GENERATED - DO NOT MODIFY BY HAND
// See: https://github.com/DevCetra/df_generate_screen
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A list of all screen routes in the app.
final generatedScreenRoutes = [
  ___GENERATED_SCREEN_ROUTES___,
];

/// A list of function references. Each returns a corresponding screen for a
/// given configuration or `null` if the given configuration does not match or
/// access is denied to the screen.
const SCREEN_MAKERS = [
  ___SCREEN_MAKERS___,
];

/// Finds the screen that corresponds to [configuration]. Returns the
/// corresponding screen or `null` if none are found or access is denied to
/// the screen.
Screen? findScreenFromConfiguration({
  required ModelScreenConfiguration configuration,
  required bool? isLoggedInAndVerified,
  required bool? isLoggedIn,
  required bool? isLoggedOut,
}) {
  for (final screenMaker in SCREEN_MAKERS) {
    final screen = screenMaker.call(
      configuration,
      isLoggedInAndVerified ?? false,
      isLoggedIn ?? false,
      isLoggedOut ?? true,
    );
    if (screen != null) {
      return screen;
    }
  }
  return null;
}

/// Finds the screen that corresponds to [configuration]. Returns the
/// corresponding screen or `null` if none are found or access is denied to
/// the screen.
Screen? findScreenFromConfigurationAndAuthService({
  required ModelScreenConfiguration configuration,
  required AuthServiceInterface? authServiceBroker,
}) {
  return findScreenFromConfiguration(
    configuration: configuration,
    isLoggedInAndVerified: authServiceBroker?.loggedInAndEmailVerified ?? false,
    isLoggedIn: authServiceBroker?.loggedIn ?? false,
    isLoggedOut: authServiceBroker?.loggedOut ?? true,
  );
}

/// Translates the current URL into a [ModelScreenConfiguration], considering
/// the user's authentication state via [authServiceBroker]. Returns the
/// matching screen configuration if accessible; otherwise, `null`.
ModelScreenConfiguration? currentUrlToConfiguration({
  required AuthServiceInterface? authServiceBroker,
}) {
  return findScreenFromConfigurationAndAuthService(
    configuration: ModelScreenConfiguration(
      args: Uri.base.queryParameters,
      path: Uri.base.path,
    ),
    authServiceBroker: authServiceBroker,
  )?.configuration;
}

/// Translates the current URL into a [ModelScreenConfiguration] under the
/// assumption that the user is **logged in and email verified**. If a
/// corresponding screen is accessible, returns its configuration; otherwise,
/// returns `null`.
ModelScreenConfiguration? currentUrlToLoginConfiguration() {
  return findScreenFromConfiguration(
    configuration: ModelScreenConfiguration(
      args: Uri.base.queryParameters,
      path: Uri.base.path,
    ),
    isLoggedInAndVerified: true,
    isLoggedIn: true,
    isLoggedOut: false,
  )?.configuration;
}

/// Translates the current URL into a [ModelScreenConfiguration] under the
/// assumption that the user is **logged out**. If a corresponding screen is
/// accessible, returns its configuration; otherwise, returns `null`.
ModelScreenConfiguration? currentUrlToLogoutConfiguration() {
  return findScreenFromConfiguration(
    configuration: ModelScreenConfiguration(
      args: Uri.base.queryParameters,
      path: Uri.base.path,
    ),
    isLoggedInAndVerified: false,
    isLoggedIn: false,
    isLoggedOut: true,
  )?.configuration;
}
```
