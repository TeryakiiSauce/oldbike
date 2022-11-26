///
/// This file provides extensions to gain more functionalities than the already included ones.
/// === === === === ===

/// Extends the functionalities of a `String()` object since Dart doesn't include everything.
///
/// For example: Adds a functionality which allows Strings to be converted to capitalize just the first letter or capitalize first letters of every word.
extension StringExtension on String {
  /// E.g., 'hello world' -> 'Hello world'
  ///
  /// Reference: https://stackoverflow.com/a/60528001
  String toCapitalized() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  /// E.g., 'hello world' -> 'Hello World'
  ///
  /// Reference: https://stackoverflow.com/a/29629114
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
