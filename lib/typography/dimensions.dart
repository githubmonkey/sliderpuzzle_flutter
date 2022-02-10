// ignore_for_file: public_member_api_docs

/// Shared dimensions but themes define their own if necessary
abstract class BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
  static double xlarge = 600;

  static double getTileSize(double cat, int dimension) {
    assert(
      cat == small || cat == medium || cat == large || cat == xlarge,
      'wrong size, must be one of dimensions',
    );
    return (cat - (dimension - 1) * 8) / dimension;
  }
}

/// Shared fonts but themes define their own if necessary
abstract class QuestionFontSize {
  static double small = 18;
  static double medium = 24;
  static double large = 32;
  static double xlarge = 40;
}

/// Shared fonts but themes define their own if necessary
abstract class TileFontSize {
  static double small = 24;
  static double medium = 30;
  static double large = 38;
  static double xlarge = 46;
}
