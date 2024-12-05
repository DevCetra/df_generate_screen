//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:df_gen_core/df_gen_core.dart';
import 'package:df_generate_dart_models_core/df_generate_dart_models_core.dart';
import 'package:df_screen_core/df_screen_core.dart';

import 'package:path/path.dart' as p;

import 'extract_insights_from_file.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> genScreenAccessApp(
  List<String> args, {
  List<String> defaultTemplates = const [
    'https://raw.githubusercontent.com/robmllze/df_generate_screen/main/templates/v1/_access.g.dart.md',
  ],
}) async {
  final parser = CliParser(
    title: 'DevCetra.com/df/tools',
    description:
        'A tool for generating screen a access file for all classes annotated @GenerateScreenBindings withing a directory.',
    example: 'gen-screen-access -i .',
    additional:
        'For contributions, error reports and information, visit: https://github.com/DevCetra.',
    params: [
      DefaultFlags.HELP.flag,
      DefaultOptions.INPUT_PATH.option.copyWith(
        defaultsTo: FileSystemUtility.i.currentDir,
      ),
      DefaultMultiOptions.TEMPLATES.multiOption.copyWith(
        defaultsTo: defaultTemplates,
      ),
      DefaultOptions.DART_SDK.option,
    ],
  );

  // ---------------------------------------------------------------------------

  final (argResults, argParser) = parser.parse(args);

  // ---------------------------------------------------------------------------

  final help = argResults.flag(DefaultFlags.HELP.name);
  if (help) {
    _print(
      printCyan,
      parser.getInfo(argParser),
    );
    exit(ExitCodes.SUCCESS.code);
  }

  // ---------------------------------------------------------------------------

  late final String inputPath;
  late final List<String> templates;
  late final String? dartSdk;
  try {
    inputPath = argResults.option(DefaultOptions.INPUT_PATH.name)!;
    templates = argResults.multiOption(DefaultMultiOptions.TEMPLATES.name);
    dartSdk = argResults.option(DefaultOptions.DART_SDK.name);
  } catch (_) {
    _print(
      printRed,
      'Missing required args! Use --help flag for more information.',
    );
    exit(ExitCodes.FAILURE.code);
  }

  // ---------------------------------------------------------------------------

  final spinner = Spinner();
  spinner.start();

  // ---------------------------------------------------------------------------

  final analysisContextCollection = createDartAnalysisContextCollection(
    {inputPath},
    dartSdk,
  );

  // ---------------------------------------------------------------------------

  _print(
    printWhite,
    'Looking for files..',
  );
  final filePathStream0 = PathExplorer(inputPath).exploreFiles();
  final filePathStream1 = filePathStream0.where((e) => _isAllowedFileName(e.path));
  List<FilePathExplorerFinding> findings;
  try {
    findings = await filePathStream1.toList();
  } catch (e) {
    spinner.stop();
    _print(
      printRed,
      'Failed to read file tree!',
    );
    exit(ExitCodes.FAILURE.code);
  }
  if (findings.isEmpty) {
    spinner.stop();
    _print(
      printYellow,
      'No files found in $inputPath!',
    );
    exit(ExitCodes.SUCCESS.code);
  }

  // ---------------------------------------------------------------------------

  final templateData = <String, String>{};
  for (final template in templates) {
    _print(
      printWhite,
      'Reading template at: $template...',
    );
    final result = await MdTemplateUtility.i.readTemplateFromPathOrUrl(
      template,
    );

    if (result.isErr) {
      spinner.stop();
      _print(
        printRed,
        ' Failed to read template!',
      );
      exit(ExitCodes.FAILURE.code);
    }
    templateData[template] = result.unwrap();
  }

  // ---------------------------------------------------------------------------

  _print(
    printWhite,
    'Generating...',
    spinner,
  );

  for (final entry in templateData.entries) {
    final fileName = p.basename(entry.key).replaceAll('.md', '');
    final template = entry.value;

    try {
      final insights = <ClassInsight<ModelGenerateScreenBindings>>[];
      for (final finding in findings) {
        final temp = await extractInsightsFromFile(
          finding.path,
          analysisContextCollection,
        );
        insights.addAll(temp);
      }
      final output = _interpolator.interpolate(template, insights, ',');
      final outputFilePath = p.join(
        inputPath,
        fileName,
      );
      await FileSystemUtility.i.writeLocalFile(outputFilePath, output);
      printWhite(
        '[gen-screen-access] ✔ Generated $fileName',
      );
    } catch (e) {
      _print(
        printRed,
        '✘ One or more files failed to generate!',
        spinner,
      );
      exit(ExitCodes.FAILURE.code);
    }
  }

  // ---------------------------------------------------------------------------

  _print(
    printWhite,
    'Fixing generated files..',
    spinner,
  );
  await fixDartFile(inputPath);

  _print(
    printWhite,
    'Formatting generated files..',
    spinner,
  );
  await fmtDartFile(inputPath);

  // ---------------------------------------------------------------------------

  spinner.stop();
  _print(
    printGreen,
    'Done!',
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void _print(
  void Function(String) print,
  String message, [
  Spinner? spinner,
]) {
  spinner?.stop();
  print('[gen-screen-access] $message');
  spinner?.start();
}

bool _isAllowedFileName(String e) {
  return !e.endsWith('.g.dart') && e.endsWith('.dart');
}

class TemplateInterpolator2<T> {
  final Map<String, String Function(T insight)> map;

  TemplateInterpolator2(this.map);

  String interpolate(
    String template,
    List<T> insights, [
    String separator = '\n',
  ]) {
    return template.replaceData(
      map.map(
        (k, v) => MapEntry(k, insights.map((e) => v(e)).join(separator)),
      ),
    );
  }
}

final _interpolator = TemplateInterpolator2<ClassInsight<GenerateScreenBindings>>(
  {
    '___SCREEN_MAKERS___': (insight) {
      final a = insight.className.toPascalCase();
      return 'maker$a';
    },
    '___PATHS___': (insight) {
      final a = insight.className.toUpperSnakeCase();
      return '...PATH_$a';
    },
    '___PATHS_NOT_REDIRECTABLE___': (insight) {
      final a = insight.className.toUpperSnakeCase();
      return '...PATH_NOT_REDIRECTABLE_$a';
    },
    '___PATHS_ALWAYS_ACCESSIBLE___': (insight) {
      final a = insight.className.toUpperSnakeCase();
      return '...PATH_ALWAYS_ACCESSIBLE_$a';
    },
    '___PATHS_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED___': (insight) {
      final a = insight.className.toUpperSnakeCase();
      return '...PATH_ACCESSIBLE_ONLY_IF_LOGGED_IN_AND_VERIFIED_$a';
    },
    '___PATHS_ACCESSIBLE_ONLY_IF_LOGGED_IN___': (insight) {
      final a = insight.className.toUpperSnakeCase();
      return '...PATH_ACCESSIBLE_ONLY_IF_LOGGED_IN_$a';
    },
    '___PATHS_ACCESSIBLE_ONLY_IF_LOGGED_OUT___': (insight) {
      final a = insight.className.toUpperSnakeCase();
      return '...PATH_ACCESSIBLE_ONLY_IF_LOGGED_OUT_$a';
    },
    '___GENERATED_SCREEN_ROUTES___': (insight) {
      final a = insight.className.toPascalCase();
      return 'generated${a}Route';
    },
  },
);