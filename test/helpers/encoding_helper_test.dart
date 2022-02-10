import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/helpers/encoding_helper.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const romanNumSeq = [
    'nulla',
    // 1-10
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    // 11-20
    'XI',
    'XII',
    'XIII',
    'XIV',
    'XV',
    'XVI',
    'XVII',
    'XVIII',
    'XIX',
    'XX',
    // 21-30
    'XXI',
    'XXII',
    'XXIII',
    'XXIV',
    'XXV',
    'XXVI',
    'XXVII',
    'XXVIII',
    'XXIX',
    'XXX',
    // 31-40
    'XXXI',
    'XXXII',
    'XXXIII',
    'XXXIV',
    'XXXV',
    'XXXVI',
    'XXXVII',
    'XXXVIII',
    'XXXIX',
    'XL',
    // 41-50
    'XLI',
    'XLII',
    'XLIII',
    'XLIV',
    'XLV',
    'XLVI',
    'XLVII',
    'XLVIII',
    'XLIX',
    'L',
    // 51
    'LI',
    'LII',
    'LIII',
    'LIV',
    'LV',
    'LVI',
    'LVII',
    'LVIII',
    'LIX',
    'LX',
    // 61
    'LXI',
    'LXII',
    'LXIII',
    'LXIV',
    'LXV',
    'LXVI',
    'LXVII',
    'LXVIII',
    'LXIX',
    'LXX',
    // 71
    'LXXI',
    'LXXII',
    'LXXIII',
    'LXXIV',
    'LXXV',
    'LXXVI',
    'LXXVII',
    'LXXVIII',
    'LXXIX',
    'LXXX',
    // 81
    'LXXXI',
    'LXXXII',
    'LXXXIII',
    'LXXXIV',
    'LXXXV',
    'LXXXVI',
    'LXXXVII',
    'LXXXVIII',
    'LXXXIX',
    'XC',
    // 91
    'XCI',
    'XCII',
    'XCIII',
    'XCIV',
    'XCV',
    'XCVI',
    'XCVII',
    'XCVIII',
    'XCIX',
    'C',
  ];

  final helper = getEncodingHelper();

  group('Encodings', () {
    test('int to roman', () {
      const encoding = AnswerEncoding.roman;

      for (var i = 0; i <= 100; i++) {
        expect(helper.encoded(i, encoding: encoding), equals(romanNumSeq[i]));
      }
    });

    test('int to binary', () {
      const encoding = AnswerEncoding.binary;

      expect(helper.encoded(0, encoding: encoding), equals('0'));
      expect(helper.encoded(1, encoding: encoding), equals('1'));
      expect(helper.encoded(2, encoding: encoding), equals('10'));
      expect(helper.encoded(63, encoding: encoding), equals('111111'));
      expect(helper.encoded(64, encoding: encoding), equals('1000000'));
      expect(helper.encoded(99, encoding: encoding), equals('1100011'));
      expect(helper.encoded(100, encoding: encoding), equals('1100100'));
    });
  });
}
