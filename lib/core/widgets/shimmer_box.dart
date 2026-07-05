import 'package:flutter/material.dart';

/// A lightweight shimmer effect built with core Flutter animations only,
/// avoiding an extra dependency just for skeleton loading.
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({super.key, this.borderRadius = 12});

  final double borderRadius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlight = Theme.of(context).colorScheme.surface;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + _controller.value * 3, 0),
              end: Alignment(0 + _controller.value * 3, 0),
              colors: [base, highlight, base],
            ),
          ),
        );
      },
    );
  }
}

/// A Pokémon-card-shaped placeholder shown while the first page loads.
class PokemonCardShimmer extends StatelessWidget {
  const PokemonCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(height: 88, child: ShimmerBox(borderRadius: 16)),
    );
  }
}
