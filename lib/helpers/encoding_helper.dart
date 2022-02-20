import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/models/pair.dart';

/// Returns a new instance of [EncodingHelper].
EncodingHelper getEncodingHelper() => EncodingHelper();

/// A encoding-related utilities.
class EncodingHelper {
  /// Arabic matches to Roman cardinals
  static const List<int> arabianRomanNumbers = [
    1000,
    900,
    500,
    400,
    100,
    90,
    50,
    40,
    10,
    9,
    5,
    4,
    1
  ];

  /// Roman cardinals
  static const List<String> romanNumbers = [
    'M',
    'CM',
    'D',
    'CD',
    'C',
    'XC',
    'L',
    'XL',
    'X',
    'IX',
    'V',
    'IV',
    'I'
  ];

  /// Converts an int to the corresponding string
  /// //TODO(s): clean up and move to pair?
  String encoded(Pair pair) {
    switch (pair.game) {
      case Game.multi:
        return pair.answer.toString();
      case Game.addition:
        return pair.answer.toString();
      case Game.roman:
        return _toRoman(pair.answer);
      case Game.binary:
        return pair.answer.toRadixString(2);
      case Game.hex:
        return pair.answer.toRadixString(16);
      // ignore: no_default_cases
      default:
        throw Exception('${pair.game} not implemented');
    }
  }

  // https://stackoverflow.com/questions/60332689/how-do-i-make-an-integer-to-roman-algorithm-in-dart
  String _toRoman(int i) {
    var num = i;

    if (num < 0) {
      return '';
    } else if (num == 0) {
      return 'nulla';
    }

    final builder = StringBuffer();
    for (var a = 0; a < arabianRomanNumbers.length; a++) {
      final times = (num / arabianRomanNumbers[a])
          .truncate(); // equals 1 only when arabianRomanNumbers[a] = num
      builder.write(romanNumbers[a] * times);
      num -= times * arabianRomanNumbers[a];
    }

    return builder.toString();
  }
}
