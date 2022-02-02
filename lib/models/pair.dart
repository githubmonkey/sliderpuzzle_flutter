import 'package:equatable/equatable.dart';

/// A par of multipliers. For comparison, use the solution only

class Pair extends Equatable {
  /// {@macro question}
  const Pair({
    required this.left,
    required this.right,
  });

  /// Left multiplier
  final int left;

  /// Right multiplier
  final int right;

  /// Calculate answer
  int get answer => left * right;

  /// Renerate string for display
  String get questionStr => '$left x $right';

  @override
  List<Object?> get props => [
    answer,
  ];
}
