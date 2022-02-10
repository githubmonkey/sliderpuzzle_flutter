
/// Shared dimensions but themes define their own if necessary
abstract class BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
  static double xlarge = 600;

  static double getTileSize(double cat, int dimension) {
    assert(cat == small || cat == medium || cat == large || cat == xlarge,
        'wrong size, must be one of dimensions');
    return (cat - (dimension - 1) * 8) / dimension;
  }
}

abstract class TileFontSize {
  static double small = 32;
  static double medium = 40;
  static double large = 54;
  static double xlarge = 58;
}

abstract class QuestionFontSize {
  static double small = 18;
  static double medium = 28;
  static double large = 36;
  static double xlarge = 42;
}
