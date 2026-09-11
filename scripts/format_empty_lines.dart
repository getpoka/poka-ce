import 'dart:io';

/// CLI tool to format Dart source files by inserting a single blank line
/// after a closing brace `}` when followed by subsequent code/statements.
///
/// Usage:
///   dart run scripts/format_empty_lines.dart [path] [--dry-run]
///
/// If no path is provided, it processes files in `lib/` and `test/`.
void main(List<String> args) {
  final isDryRun = args.contains('--dry-run');
  final paths = args.where((arg) => !arg.startsWith('--')).toList();

  final targets = paths.isEmpty ? ['lib', 'test'] : paths;
  var modifiedCount = 0;
  var scannedCount = 0;

  for (final target in targets) {
    final entity = FileSystemEntity.typeSync(target);
    if (entity == FileSystemEntityType.file) {
      if (_shouldProcess(target)) {
        scannedCount++;
        if (_processFile(File(target), isDryRun: isDryRun)) {
          modifiedCount++;
        }
      }
    } else if (entity == FileSystemEntityType.directory) {
      final dir = Directory(target);
      final files = dir.listSync(recursive: true).whereType<File>();
      for (final file in files) {
        if (_shouldProcess(file.path)) {
          scannedCount++;
          if (_processFile(file, isDryRun: isDryRun)) {
            modifiedCount++;
          }
        }
      }
    } else {
      stderr.writeln('Warning: Target "$target" does not exist.');
    }
  }

  stdout.writeln(
    '\nScan complete. Scanned $scannedCount Dart file(s). '
    '${isDryRun ? 'Would modify' : 'Modified'} $modifiedCount file(s).',
  );

  if (!isDryRun && modifiedCount > 0) {
    stdout.writeln('Run "dart format ." to normalize and align the updated files.');
  }
}

/// Determines whether the file at [filePath] should be processed.
/// Excludes generated code files and non-Dart files.
bool _shouldProcess(String filePath) {
  if (!filePath.endsWith('.dart')) return false;
  if (filePath.endsWith('.g.dart')) return false;
  if (filePath.endsWith('.freezed.dart')) return false;
  return true;
}

/// Processes a single [file], inserting empty lines where appropriate.
/// Returns `true` if the file content changed.
bool _processFile(File file, {required bool isDryRun}) {
  final content = file.readAsStringSync();
  final updated = formatBlankLinesAfterBraces(content);

  if (content != updated) {
    if (isDryRun) {
      stdout.writeln('[DRY-RUN] Would update: ${file.path}');
    } else {
      file.writeAsStringSync(updated);
      stdout.writeln('[UPDATED] ${file.path}');
    }
    return true;
  }
  return false;
}

/// Formats Dart code string by inserting a blank line after standalone closing
/// braces `}` that are followed by executable statements.
String formatBlankLinesAfterBraces(String content) {
  final lines = content.split('\n');
  final result = <String>[];
  var inMultilineString = false;
  var multilineDelimiter = '';
  var inMultilineComment = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();

    result.add(line);

    // Track multiline block comments (/* ... */)
    if (!inMultilineString) {
      if (inMultilineComment) {
        if (trimmed.contains('*/')) {
          inMultilineComment = false;
        }
        continue;
      } else if (trimmed.startsWith('/*') && !trimmed.contains('*/')) {
        inMultilineComment = true;
        continue;
      }
    }

    // Track multiline raw/interpolated strings (''' or """)
    if (!inMultilineComment) {
      if (inMultilineString) {
        if (trimmed.contains(multilineDelimiter)) {
          inMultilineString = false;
          multilineDelimiter = '';
        }
        continue;
      } else {
        if (trimmed.contains("'''") && (trimmed.indexOf("'''") == trimmed.lastIndexOf("'''"))) {
          inMultilineString = true;
          multilineDelimiter = "'''";
          continue;
        } else if (trimmed.contains('"""') && (trimmed.indexOf('"""') == trimmed.lastIndexOf('"""'))) {
          inMultilineString = true;
          multilineDelimiter = '"""';
          continue;
        }
      }
    }

    // Only inspect lines that end with a standalone closing brace `}`
    // Strip inline comments at the end of line, e.g. `} // comment`
    final cleanLine = _stripTrailingComment(trimmed);
    if (!cleanLine.endsWith('}')) {
      continue;
    }

    // Do not process single-line constructs, e.g. `{ return 0; }`
    if (cleanLine.contains('{')) {
      continue;
    }

    // Must have a following line to inspect
    if (i + 1 >= lines.length) {
      continue;
    }

    final nextLine = lines[i + 1];
    final nextTrimmed = nextLine.trim();

    // Skip if there is already a blank line
    if (nextTrimmed.isEmpty) {
      continue;
    }

    // Skip if the next line continues the existing construct or closes another block:
    // - Closing delimiters: `}`, `)`, `]`, `,`, `;`
    // - Method/cascade chaining: `.`, `..`
    // - Control flow continuations: `else`, `catch`, `on `, `finally`, `while`
    if (nextTrimmed.startsWith('}') ||
        nextTrimmed.startsWith(')') ||
        nextTrimmed.startsWith(']') ||
        nextTrimmed.startsWith(',') ||
        nextTrimmed.startsWith(';') ||
        nextTrimmed.startsWith('.') ||
        nextTrimmed.startsWith('..') ||
        nextTrimmed.startsWith('else') ||
        nextTrimmed.startsWith('catch') ||
        nextTrimmed.startsWith('on ') ||
        nextTrimmed.startsWith('finally') ||
        nextTrimmed.startsWith('while')) {
      continue;
    }

    // Skip if next line begins with closing punctuation wrapped with whitespace
    if (RegExp(r'^[}\]\),;]').hasMatch(nextTrimmed)) {
      continue;
    }

    // Valid standalone `}` followed by new code: insert 1 empty line
    result.add('');
  }

  return result.join('\n');
}

/// Strips trailing single-line comments from a code line.
String _stripTrailingComment(String line) {
  final idx = line.indexOf('//');
  if (idx != -1) {
    return line.substring(0, idx).trim();
  }
  return line;
}
