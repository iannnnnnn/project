// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';
///////////////////////////////////////////////////////////
import 'package:intl/intl.dart' show NumberFormat;

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(1000, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 1),
    value: (item) => List.generate(
        item = 2, (index) => Event('income/outcome $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s outcome'),
      Event('Today\'s income'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CurrencyFormat {
  static String format(double value, {required String symbol}) {
    if (value > 999999) {
      return NumberFormat.compactSimpleCurrency(
        name: symbol,
        decimalDigits: 4,
      ).format(value);
    }
    return NumberFormat.simpleCurrency(
      name: symbol,
      decimalDigits: 1,
    ).format(value);
  }
}
