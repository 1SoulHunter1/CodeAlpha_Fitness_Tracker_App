import 'package:intl/intl.dart';

// Formats a number with commas for better readability (e.g., 10000 -> 10,000)
String formatNumber(int number) {
  return NumberFormat.decimalPattern().format(number);
}

// Formats a DateTime object into a more readable string (e.g., "Oct 25, 2023")
String formatDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}
