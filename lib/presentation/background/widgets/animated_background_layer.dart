import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/background_layer.dart';
import 'package:flutter_puzzle_hack/data/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/animation-utils/position_tween.dart';

class AnimatedBackgroundLayer extends StatefulWidget {
  final BackgroundLayer layer;

  const AnimatedBackgroundLayer({
    Key? key,
    required this.layer,
  }) : super(key: key);

  @override
  _AnimatedBackgroundLayerState createState() => _AnimatedBackgroundLayerState();
}

class _AnimatedBackgroundLayerState extends State<AnimatedBackgroundLayer> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Position> _position;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _position = PositionTween(
      begin: widget.layer.outOfViewPosition,
      end: widget.layer.position,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _position,
      child: Image.asset(
        widget.layer.assetUrl,
        width: widget.layer.size.width,
      ),
      builder: (c, image) => Positioned(
        left: _position.value.left,
        top: _position.value.top,
        right: _position.value.right,
        bottom: _position.value.bottom,
        child: image!,
      ),
    );
  }
}