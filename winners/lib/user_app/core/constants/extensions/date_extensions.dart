extension DateTransformation on DateTime {
  /// Returns only year, month and day
  DateTime get date => DateTime(year, month, day);

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Returns the earliest date
  DateTime min(DateTime other) {
    return (millisecondsSinceEpoch < other.millisecondsSinceEpoch)
        ? this
        : other;
  }

  /// Returns a later date
  DateTime max(DateTime other) {
    return (millisecondsSinceEpoch > other.millisecondsSinceEpoch)
        ? this
        : other;
  }

  /// Returns difference between two dates in days
  int differenceInDays(DateTime other) {
    return DateTime(year, month, day)
        .difference(DateTime(other.year, other.month, other.day))
        .inDays;
  }

  /// Returns difference between two dates in hours
  int differenceInHours(DateTime other) {
    return DateTime(year, month, day)
        .difference(DateTime(other.year, other.month, other.day))
        .inHours;
  }

  /// Returns difference between two dates in minutes
  int differenceInMinutes(DateTime other) {
    return DateTime(year, month, day)
        .difference(DateTime(other.year, other.month, other.day))
        .inMinutes;
  }

  /// Returns difference between two dates in seconds
  int differenceInSeconds(DateTime other) {
    return DateTime(year, month, day)
        .difference(DateTime(other.year, other.month, other.day))
        .inSeconds;
  }

  /// Returns difference between two dates in seconds
  int differenceInYears(DateTime other) {
    return DateTime(year).difference(DateTime(other.year)).inDays ~/ 365;
  }
}

extension DateChecks on DateTime {
  /// Returns `true` if the date is today
  bool get isToday {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day;
  }

  /// Returns `true` if the date is yesterday
  bool get isYesterday {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day - 1;
  }

  /// Returns `true` if the date is tomorrow
  bool get isTomorrow {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day + 1;
  }

  /// Returns `true` if two dates are equal by year, month and day
  bool isSameDay(DateTime other) {
    return year == other.year && month == month && day == other.day;
  }

  /// Returns true if [other] is in the same year as [this].
  /// Does not account for timezones
  bool isAtSameYearAs(DateTime other) => year == other.year;

  /// Returns true if [other] is in the same month as [this].
  /// This means the exact month, including year.
  /// Does not account for timezones
  bool isAtSameMonthAs(DateTime other) {
    return isAtSameYearAs(other) && month == other.month;
  }

  /// Returns true if [other] is on the same day as [this].
  /// This means the exact day, including year and month.
  /// Does not account for timezones
  bool isAtSameDayAs(DateTime other) {
    return isAtSameMonthAs(other) && day == other.day;
  }

  /// Returns true if [other] is at the same hour as [this].
  /// This means the exact hour, including year, month and day.
  /// Does not account for timezones
  bool isAtSameHourAs(DateTime other) {
    return isAtSameDayAs(other) && hour == other.hour;
  }

  /// Returns true if [other] is at the same minute as [this].
  /// This means the exact minute, including year, month, day and hour.
  /// Does not account for timezones
  bool isAtSameMinuteAs(DateTime other) {
    return isAtSameHourAs(other) && minute == other.minute;
  }

  /// Returns true if [other] is at the same second as [this].
  /// This means the exact second, including year, month, day, hour and minute.
  /// Does not account for timezones.
  bool isAtSameSecondAs(DateTime other) {
    return isAtSameMinuteAs(other) && second == other.second;
  }
}
