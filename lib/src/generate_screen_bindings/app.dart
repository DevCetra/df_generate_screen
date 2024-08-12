//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:args/args.dart';
import 'package:df_gen_core/df_gen_core.dart';

import 'generate.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A command line app for generating screen bindings.
Future<void> runGenerateScreenBindingsApp(List<String> args) async {
  await runCommandLineApp(
    title: 'Generate Screen Bindings',
    description: 'A command line app for generating screens bindings',
    args: args,
    parser: ArgParser()
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Help information.',
      )
      ..addOption(
        'roots',
        abbr: 'r',
        help: 'Root directory paths separated by `&`.',
        defaultsTo: 'lib',
      )
      ..addOption(
        'subs',
        abbr: 's',
        help: 'Sub-directory paths separated by `&`.',
        defaultsTo: 'screens',
      )
      ..addOption(
        'patterns',
        abbr: 'p',
        help: 'Path patterns separated by `&`.',
      )
      ..addOption(
        'template',
        abbr: 't',
        help: 'Template file path.',
      )
      ..addOption(
        'dart-sdk',
        help: 'Dart SDK path.',
      ),
    onResults: (parser, results) {
      return _ArgsChecker(
        fallbackDartSdkPath: results['dart-sdk'],
        templateFilePath: results['template'],
        rootPaths: splitArg(results['roots'])?.toSet(),
        subPaths: splitArg(results['subs'])?.toSet(),
        pathPatterns: splitArg(results['patterns'])?.toSet(),
      );
    },
    action: (parser, results, args) async {
      await generateScreenBindings(
        fallbackDartSdkPath: args.fallbackDartSdkPath,
        templateFilePath: args.templateFilePath,
        rootDirPaths: args.rootPaths!,
        subDirPaths: args.subPaths ?? const {},
        pathPatterns: args.pathPatterns ?? const {},
      );
    },
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _ArgsChecker extends ValidArgsChecker {
  //
  //
  //

  final Set<String>? rootPaths;
  final Set<String>? subPaths;
  final Set<String>? pathPatterns;
  final String? templateFilePath;
  final String? fallbackDartSdkPath;

  //
  //
  //

  const _ArgsChecker({
    required this.rootPaths,
    required this.subPaths,
    required this.pathPatterns,
    required this.templateFilePath,
    required this.fallbackDartSdkPath,
  });

  //
  //
  //

  @override
  List<dynamic> get args {
    final paths = [
      if (this.rootPaths != null) this.rootPaths,
      if (this.subPaths != null) this.subPaths,
    ];
    return [
      paths,
      ...paths,
      if (this.pathPatterns != null) this.pathPatterns,
      if (this.templateFilePath != null) this.templateFilePath,
      if (this.fallbackDartSdkPath != null) this.fallbackDartSdkPath,
    ];
  }
}