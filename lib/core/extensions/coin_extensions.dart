import 'package:intl/intl.dart';

extension IntCoinFormatting on int {
  /// Formats an integer as a readable coin display string
  ///
  /// [style] determines the formatting approach:
  /// - [CoinFormatStyle.standard]: Uses commas as separators (15,030)
  /// - [CoinFormatStyle.abbreviated]: Uses K, M, B suffixes (15K, 2.5M)
  /// - [CoinFormatStyle.compact]: Uses shorter representation (15K)
  String formattedCoins({CoinFormatStyle style = CoinFormatStyle.abbreviated}) {
    switch (style) {
      case CoinFormatStyle.standard:
        // Format with comma separators: 15,030
        final formatter = NumberFormat('#,###');
        return formatter.format(this);

      case CoinFormatStyle.abbreviated:
        // Format with K, M, B, T suffixes with decimals when needed
        if (this < 1000) return this.toString();

        if (this < 1000000) {
          final value = this / 1000.0;
          return value % 1 == 0
              ? '${value.toInt()}K'
              : '${value.toStringAsFixed(1)}K';
        }

        if (this < 1000000000) {
          final value = this / 1000000.0;
          return value % 1 == 0
              ? '${value.toInt()}M'
              : '${value.toStringAsFixed(1)}M';
        }

        if (this < 1000000000000) {
          final value = this / 1000000000.0;
          return value % 1 == 0
              ? '${value.toInt()}B'
              : '${value.toStringAsFixed(1)}B';
        }

        final value = this / 1000000000000.0;
        return value % 1 == 0
            ? '${value.toInt()}T'
            : '${value.toStringAsFixed(1)}T';

      case CoinFormatStyle.compact:
        // Uses platform's compact number formatting
        final formatter = NumberFormat.compact();
        return formatter.format(this);
    }
  }
}

/// Format styles for displaying coin values
enum CoinFormatStyle {
  /// Uses comma separators: 15,030
  standard,

  /// Uses K, M, B suffixes with custom implementation: 15K, 2.5M
  abbreviated,

  /// Uses platform's compact number formatting
  compact
}
