extension BoolExtensions on bool {
  /// Returns the invert
  /// true.not() = false
  /// false.not() = true
  bool not() => !this;

  /// true.and(true) = true
  /// true.and(false) = false
  /// false.and(true) = false
  /// false.and(false) = false
  bool and(bool other) => this && other;

  /// true.or(true) = true
  /// true.or(false) = true
  /// false.or(true) = true
  /// false.or(false) = false
  bool or(bool other) => this || other;
}
