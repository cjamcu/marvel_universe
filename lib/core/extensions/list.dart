extension ListExtensions<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    final matches = where(test);
    return matches.isEmpty ? null : matches.first;
  }
}
