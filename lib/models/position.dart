import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final double left;
  final double top;

  const Position({
    required this.left,
    required this.top,
  });

  String get asString => 'Left: ${left.toStringAsFixed(2)} | Top: ${top.toStringAsFixed(2)}';

  bool isBetween(Position a, Position b) {
    return (left >= a.left && left <= b.left && top >= a.top && top <= b.top) || (left >= b.left && left <= a.left && top >= b.top && top <= a.top);
  }

  Position get absolute => Position(left: left.abs(), top: top.abs());

  @override
  List<Object?> get props => [left, top];
}
