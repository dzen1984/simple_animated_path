import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import 'path_configuration.dart';

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> animation;
  final List<PathConfiguration> pathConfigurations;

  const AnimatedPathPainter({
    required this.animation,
    required this.pathConfigurations,
  }): super(repaint: animation);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (pathConfigurations.isEmpty || animation.value == 0) {
      return;
    }
    for (var configuration in pathConfigurations) {
      final path = _calculatePath(
        configuration.path,
        animation.value,
      );
      canvas.drawPath(path, configuration.paint);
    }
  }

  Path _calculatePath(Path path, double progress) {
    double fnCombine(double prev, PathMetric metric) => prev + metric.length;
    final resultPath = Path();
    final sumLength = path.computeMetrics().fold<double>(0.0, fnCombine);
    final length = sumLength * progress;
    var currentLength = 0.0;
    var metrics = path.computeMetrics();
    for (var metric in metrics) {
      final nextLength = currentLength + metric.length;
      if (nextLength > length) {
        final remainingLength = length - currentLength;
        final segment = metric.extractPath(0.0, remainingLength);
        resultPath.addPath(segment, Offset.zero);
        break;
      }
      final segment = metric.extractPath(0.0, metric.length);
      resultPath.addPath(segment, Offset.zero);
      currentLength = nextLength;
    }
    return resultPath;
  }

}
