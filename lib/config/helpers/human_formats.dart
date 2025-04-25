

import 'package:intl/intl.dart';

class HumanFormats {

  static String formatNumber(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      locale: 'en',
    ).format(number);

    return formattedNumber;
  }

  static String number( double number, [ int decimals = 0 ] ) {

    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formattedNumber;
  }
}
    