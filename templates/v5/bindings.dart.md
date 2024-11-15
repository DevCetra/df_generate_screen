```dart
//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// GENERATED - DO NOT MODIFY BY HAND
// See: https://github.com/DevCetra/df_generate_screen
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

// ignore_for_file: unused_element

part of '___CLASS_FILE___';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final _globalKey = GlobalKey<_View>();

/// Serves as the blueprint for the [___CLASS___] screen.
/// It outlines the screen's properties and behaviors prior to routing.
class ___CONFIGURATION_CLASS___ extends ModelScreenConfiguration {
  //
  //
  //

  ___IP0___
  ___QP0___

  factory ___CONFIGURATION_CLASS___({
    ___IP1___
    ___QP1___
    Map<dynamic, dynamic>? $args,
  }) {
    return ___CONFIGURATION_CLASS___.optional(
      args: {
         ___IP2___
         ___QP2___
        ...?$args,
      }.nonNulls,
    );
  }

  //
  //
  //

  ___CONFIGURATION_CLASS___.optional({
    Map<dynamic, dynamic>? args,
  }): super.optional(
    title: null,
    path: _PATH,
    args: args ?? {},
    isAccessibleOnlyIfLoggedInAndVerified: _IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED,
    isAccessibleOnlyIfLoggedIn: _IS_ACCESSIBLE_ONLY_IF_LOGGED_IN,
    isAccessibleOnlyIfLoggedOut: _IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT,
    isRedirectable: _IS_REDIRECTABLE,
  );

  //
  //
  //

  /// The name of the corresponding [Screen] class.
  static const CLASS = _CLASS;

  /// The path of the corresponding [Screen].
  static const PATH = _PATH;

  /// The segment of the corresponding [Screen] path.
  static const SEGMENT = _SEGMENT;

  /// The translation key for the corresponding [Screen].
  static const TR_KEY = _TR_KEY;

  /// Whether the corresponding [Screen] is only accessible if the user is logged in and verified.
  static const IS_ACCESSIBLE_ONLY_IF_LOGGED_IN = _IS_ACCESSIBLE_ONLY_IF_LOGGED_IN;

  /// Whether the corresponding [Screen] is only accessible if the user is logged in.
  static const IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED = _IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED;

  /// Whether the corresponding [Screen] is only accessible if the user is logged out.
  static const IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT = _IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT;

  /// Whether the corresponding [Screen] is redirectable, i.e., if it can be requested from the browser URL.
  static const IS_REDIRECTABLE = _IS_REDIRECTABLE;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Extend this class to create a controller for the [___CLASS___] screen.
abstract base class _ControllerBroker<T1 extends ___CLASS___, T2 extends _View>
    extends ScreenController<___CONFIGURATION_CLASS___> {

  /// The [Screen] that corresponds to `this` controller.
  late final screen = super.superScreen as T1;

  /// The [State] that corresponds to `this` controller.
  late final state = super.superState as T2;

  /// The [ModelScreenConfiguration] that corresponds to `this` controller.
  late final configuration = super.internalConfiguration ?? ___CONFIGURATION_CLASS___.optional(
    args: screen.configuration?.args,
  );

  _ControllerBroker(
    super.superScreen,
    super.superState, [
    super.internalConfiguration,
  ]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// The generated [GoRoute] that corresponds to [___CLASS___].
final generated___CLASS___Route = GoRoute(
  path: _SEGMENT,
  pageBuilder: (context, state) {
    final extraConfiguration = letAsOrNull<ModelScreenConfiguration>(state.extra);
    final urlConfiguration = urlToScreenConfiguration(
      url: state.uri,
      isAccessibleOnlyIfLoggedIn: ___CONFIGURATION_CLASS___.IS_ACCESSIBLE_ONLY_IF_LOGGED_IN,
      isAccessibleOnlyIfLoggedInAndVerified: ___CONFIGURATION_CLASS___.IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED,
      isAccessibleOnlyIfLoggedOut: ___CONFIGURATION_CLASS___.IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT,
      isRedirectable: ___CONFIGURATION_CLASS___.IS_REDIRECTABLE,
      title: null,
    );
    final configuration = extraConfiguration ?? urlConfiguration;
    return NoTransitionPage(
      key: state.pageKey,
      child: ___CLASS___(
        key: _globalKey,
        configuration: configuration,
      ),
    );
  },
);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns a [___CLASS___] instance if the [configuration] is of type
/// [___CONFIGURATION_CLASS___] and if the current authentication status matches
/// [isLoggedInAndVerified], [isLoggedIn], and [isLoggedOut].
Screen? maker___CLASS___(
  ModelScreenConfiguration configuration,
  bool isLoggedInAndVerified,
  bool isLoggedIn,
  bool isLoggedOut,
) {
  if ((_IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED && !isLoggedInAndVerified) || (_IS_ACCESSIBLE_ONLY_IF_LOGGED_IN && !isLoggedIn) || (_IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT && !isLoggedOut)) {
    return null;
  }
  if (configuration is ___CONFIGURATION_CLASS___) {
    return ___CLASS___(
      key: _globalKey,
      configuration: configuration,
    );
  }
  if (RegExp(r'^(' + _PATH + r')([?/].*)?$')
      .hasMatch(Uri.decodeComponent(configuration.path ?? ''))) {
    final temp = ___CONFIGURATION_CLASS___.optional(
      args: configuration.args,
    );
    return ___CLASS___(
      key: _globalKey,
      configuration: temp,
    );
  }
  return null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A controller type corresponding to [___CLASS___].
typedef T___CLASS___Controller =  _ControllerBroker<___CLASS___, _View>;

/// A [AdaptiveScreenView] type corresponding to [___CLASS___].
typedef TAdaptive___CLASS___View = AdaptiveScreenView<___CLASS___, ___CONFIGURATION_CLASS___, ___CLASS___Controller>;

/// A [ScreenView] type corresponding to [___CLASS___].
typedef T___CLASS___View = ScreenView<___CLASS___, ___CONFIGURATION_CLASS___, ___CLASS___Controller>;

/// A [ScreenPageView] type corresponding to [___CLASS___].
typedef T___CLASS___PageView<T extends ScreenPage> = ScreenPageView<T, ___CONFIGURATION_CLASS___, ___CLASS___Controller>;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

base class ____CLASS___ extends Screen {
  const ____CLASS___({
    required super.key,
    required super.configuration,
    super.controllerCacheTimeout = Duration.zero,
  });

  @override
  createState() => _View();

  @override
  createController(
    Screen screen,
    ScreenView state,
  ) {
    return ___CLASS___Controller(screen, state);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// The following constants are set by the generator based on the provided
// options. Together they form the behavior of the generated screen.

const _IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED = ___IS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED___;
const _IS_ACCESSIBLE_ONLY_IF_LOGGED_IN = ___IS_ACCESSIBLE_ONLY_IF_LOGGED_IN___;
const _IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT = ___IS_ACCESSIBLE_ONLY_IF_LOGGED_OUT___;
const _IS_REDIRECTABLE = ___IS_REDIRECTABLE___;
const _CLASS = '___CLASS___';
const _SEGMENT = '___SCREEN_SEGMENT___';
const _PATH = '/$_SEGMENT';
const _TR_KEY = 'screens.___CLASS___';
const _DEFAULT_TITLE = '___DEFAULT_TITLE___';
```
