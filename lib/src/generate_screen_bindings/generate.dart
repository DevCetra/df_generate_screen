//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:df_gen_core/df_gen_core.dart';
import 'package:df_log/df_log.dart';
import 'package:df_screen_core/df_screen_core.dart';

import '_extract_class_insights_from_dart_file.dart';
import '_generator_converger.dart';
import '_insight_mappers.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Note: Returns all the annotated screen class names.
Future<void> generateScreenBindings({
  String? fallbackDartSdkPath,
  String? templateFilePath,
  required Set<String> rootDirPaths,
  Set<String> subDirPaths = const {},
  Set<String> pathPatterns = const {},
}) async {
  // Notify start.
  debugLogStart('Starting generator. Please wait...');

  // Explore all source paths.
  final sourceFileExporer = PathExplorer(
    categorizedPathPatterns: const [
      CategorizedPattern(
        category: _Categories.DART,
        pattern: r'.*\.dart$',
      ),
    ],
    dirPathGroups: {
      CombinedPaths(
        rootDirPaths,
        subPaths: subDirPaths,
        pathPatterns: pathPatterns,
      ),
    },
  );
  final sourceFileExplorerResults = await sourceFileExporer.explore();

  final template = extractCodeFromMarkdown(
    await loadFileFromGitHub(
      username: 'robmllze',
      repo: 'df_generate_screen',
      filePath: [
        templateFilePath ?? 'templates/msm1/bindings.dart.md',
      ].join('/'),
    ),
  );

  // ---------------------------------------------------------------------------

  // Create context for the Dart analyzer.
  final analysisContextCollection = createDartAnalysisContextCollection(
    sourceFileExporer.dirPathGroups.first.paths,
    fallbackDartSdkPath,
  );

  final classInsights = <ClassInsight<ModelGenerateScreenBindings>>[];

  // For each file...
  for (final filePathResult in sourceFileExplorerResults.filePathResults
      .where((e) => e.category == _Categories.DART)) {
    final filePath = filePathResult.path;

    // Extract insights from the file.
    final temp = await extractClassInsightsFromDartFile(
      analysisContextCollection,
      filePath,
    );

    classInsights.addAll(temp);
  }

  // ---------------------------------------------------------------------------

  if (classInsights.isNotEmpty) {
    // Converge what was gathered to generate the output.
    await generatorConverger.converge(
      classInsights,
      [template],
      insightMappers,
    );
  }

  // ---------------------------------------------------------------------------

  // Notify end.
  debugLogStop('Done!');
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum _Categories {
  DART,
}
