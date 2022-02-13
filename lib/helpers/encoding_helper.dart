import 'package:very_good_slide_puzzle/models/pair.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';

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
  String encoded(Pair pair, {required AnswerEncoding encoding}) {
    switch (encoding) {
      case AnswerEncoding.multi:
        return pair.answer.toString();
      case AnswerEncoding.addition:
        return pair.answer.toString();
      case AnswerEncoding.roman:
        return _toRoman(pair.answer);
      case AnswerEncoding.binary:
        return pair.answer.toRadixString(2);
      case AnswerEncoding.hex:
        return pair.answer.toRadixString(16);
      // ignore: no_default_cases
      default:
        throw Exception('$encoding not implemented');
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
