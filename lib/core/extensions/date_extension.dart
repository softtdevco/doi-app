// Package imports:
import 'package:intl/intl.dart';

extension ToDateTime on DateTime? {
  String get toDateTime => (this == null)
      ? ''
      : DateFormat('MMM d, hh:mm a').format(this!.toLocal());

  String get toDate =>
      (this == null) ? '' : DateFormat('MMM d, y').format(this!.toLocal());

  String get toDateTimeYear => (this == null)
      ? ''
      : DateFormat('MMM d, y hh:mm a').format(this!.toLocal());

  String get toDateMonthYear =>
      (this == null) ? '' : DateFormat('dd/MM/yy').format(this!.toLocal());

  String get toTxnDate => (this == null)
      ? ''
      : DateFormat('dd MMM yyyy, hh:mma').format(this!.toLocal());
  String get toReceiptDate => (this == null)
      ? ''
      : DateFormat('hh:mma, EEE MMM dd, yyyy').format(this!.toLocal());
  String get toMonthDate =>
      (this == null) ? '' : DateFormat('d MMMM y').format(this!);
  String get toMonthDatea =>
      (this == null) ? '' : DateFormat('d MMMM').format(this!);
  String get toMonthDates {
    if (this == null) return '';
    return DateFormat("MMMM d").format(this!) +
        _getDaySuffix(this!.day) +
        ', ${this!.year}';
  }

  String get toMonthDatess {
    if (this == null) return '';
    return DateFormat("MMM d").format(this!) +
        _getDaySuffix(this!.day) +
        ', ${this!.year}';
  }

  String get formattedTimeAndDay {
    final time = DateFormat('h:mm a').format(this!);
    final day = DateFormat('d').format(this!);
    final month = DateFormat('MMMM').format(this!);

    return '$time - $day${_getDaySuffix(this!.day)} $month';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  DateTime get splitDateOnly => DateTime.parse(toString().split(' ')[0]);

  String get getHeaderDate => this!.day == DateTime.now().day
      ? 'Today'
      : this!.day == DateTime.now().day - 1
          ? 'Yesterday'
          : DateFormat('MMM dd, yyyy').format(this!);

  String get timeAgo {
    if (this == null) return '';
    final difference = DateTime.now().difference(this!);
    final seconds = difference.inSeconds;
    final minutes = difference.inMinutes;
    final hours = difference.inHours;
    final days = difference.inDays;

    // Calculate months and years
    final months = (days / 30).floor(); // Approximate months
    final years = (days / 365).floor(); // Approximate years

    if (years > 0) {
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (months > 0) {
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (days > 0) {
      return days == 1 ? '1 day ago' : '$days days ago';
    } else if (hours > 0) {
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    } else if (minutes > 0) {
      return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
    } else if (seconds > 0) {
      return seconds == 1 ? '1 second ago' : '$seconds seconds ago';
    } else {
      return 'Just now';
    }
  }

  String get toTime => (this == null)
      ? ''
      : DateFormat('hh:mm a').format(this!.toLocal()).toLowerCase();
}

String calculateDateRange(DateTime startDate, DateTime endDate) {
  // Calculate the difference in days
  final daysDifference = endDate.difference(startDate).inDays;

  return '$daysDifference ${daysDifference == 1 ? 'day' : 'days'}';
}
