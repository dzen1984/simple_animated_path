import 'package:flutter/material.dart';

import '_animated_path_painter.dart';
import 'path_configuration.dart';

class SimpleAnimatedPathWidget extends StatefulWidget {
  final Size size;
  final Animation<double> animation;
  final List<PathConfiguration> configurations;

  const SimpleAnimatedPathWidget({
    super.key,
    required this.size,
    required this.animation,
    required this.configurations,
  });

  @override
  State<SimpleAnimatedPathWidget> createState() => _SimpleAnimatedPathWidgetState();
}

class _SimpleAnimatedPathWidgetState extends State<SimpleAnimatedPathWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size.width, widget.size.height),
      foregroundPainter: AnimatedPathPainter(
        animation: widget.animation,
        pathConfigurations: widget.configurations,
      ),
    );
  }
}
