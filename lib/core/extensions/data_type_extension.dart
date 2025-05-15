import 'package:intl/intl.dart';

extension FormatAmount on num? {
  String get formatAmount {
    if (this == null) {
      return '';
    }
    return NumberFormat.currency(
      name: '',
      decimalDigits: isInteger(this!) ? 0 : 2,
    ).format(this);
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();
}