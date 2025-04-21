

import 'package:intl/intl.dart';

class HumanFormats {

  static String formatNumber(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      locale: 'en',
    ).format(number);

    return formattedNumber;
  }
}
    