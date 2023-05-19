

import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension FormatDate on DateTime{
  String formatDateToString(){
    return DateFormat('yyyy-MM-dd').format(this).toString();
  }
}

extension FormatAlphaDate on DateTime{
  String formatDateToAlphaNumeric(){
    return DateFormat('dd MMMM y').format(this).toString();
  }
}