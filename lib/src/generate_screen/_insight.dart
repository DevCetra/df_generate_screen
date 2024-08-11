//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See LICENSE file
// in root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class Insight {
  final String screenClassName;
  final String bindingsFileName;
  final String controllerFileName;
  final String screenFileName;
  final String viewFileName;
  final bool isAccessibleOnlyIfLoggedIn;
  final bool isAccessibleOnlyIfLoggedInAndVerified;
  final bool isAccessibleOnlyIfLoggedOut;
  final bool isRedirectable;
  final Map<String, String> internalParameters;
  final Set<String> queryParameters;
  final String path;
  final String title;
  final Set<String> partFileDirs;

  const Insight({
    required this.screenClassName,
    required this.bindingsFileName,
    required this.controllerFileName,
    required this.screenFileName,
    required this.viewFileName,
    required this.isAccessibleOnlyIfLoggedIn,
    required this.isAccessibleOnlyIfLoggedInAndVerified,
    required this.isAccessibleOnlyIfLoggedOut,
    required this.isRedirectable,
    required this.internalParameters,
    required this.queryParameters,
    required this.path,
    required this.title,
    required this.partFileDirs,
  });
}