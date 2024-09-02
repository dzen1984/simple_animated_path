import 'dart:math';

import 'package:simple_animated_path/simple_animated_path.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Animated Path Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _animTimeMillis = 1000;
  late AnimationController _animCtrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animTimeMillis),
    );
    _anim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animCtrl,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = 10;
    const defaultItemWidth = 200.0;
    final mqSize = MediaQuery.of(context).size;
    final itemSize = (min((mqSize.width / 2 - padding * 3), defaultItemWidth));
    const iterations = 7;
    final step = itemSize / iterations;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Example'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: itemSize * 2 + padding * 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _animCtrl.forward();
                      },
                      child: const Text('Forward'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        _animCtrl.reverse();
                      },
                      child: const Text('Reverse'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: itemSize,
                      height: itemSize,
                      color: Colors.blue,
                      child: SimpleAnimatedPathWidget(
                        animation: _anim,
                        size: Size(itemSize, itemSize),
                        configurations: [
                          ...List.generate(
                            iterations,
                            (index) => PathConfiguration(
                              paint: Paint()
                                ..color = Colors.white
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..isAntiAlias = true
                                ..strokeCap = StrokeCap.round,
                              path: _circlePath(
                                Size(
                                  itemSize - (step * index),
                                  itemSize - (step * index),
                                ),
                              ),
                            ),
                          ),
                          ...[
                            PathConfiguration(
                              paint: Paint()
                                ..color = Colors.white
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..isAntiAlias = true
                                ..strokeCap = StrokeCap.round,
                              path: Path()
                                ..moveTo(0, 0)
                                ..lineTo(itemSize, itemSize),
                            ),
                          ]
                        ],
                      ),
                    ),
                    Container(
                      width: itemSize,
                      height: itemSize,
                      color: Colors.amber,
                      child: SimpleAnimatedPathWidget(
                        animation: _anim,
                        size: Size(itemSize, itemSize),
                        configurations: [
                          ...List.generate(
                            iterations,
                            (index) => PathConfiguration(
                              paint: Paint()
                                ..color = Colors.white
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..isAntiAlias = true
                                ..strokeCap = StrokeCap.round,
                              path: _squarePath(Size(itemSize - (step * index),
                                  itemSize - (step * index))),
                            ),
                          ),
                          ...[
                            PathConfiguration(
                              paint: Paint()
                                ..color = Colors.white
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..isAntiAlias = true
                                ..strokeCap = StrokeCap.round,
                              path: Path()
                                ..moveTo(0, 0)
                                ..lineTo(itemSize, itemSize),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: itemSize,
                      height: itemSize,
                      color: Colors.indigo,
                      child: SimpleAnimatedPathWidget(
                        animation: _anim,
                        size: Size(itemSize, itemSize),
                        configurations: [
                          ...List.generate(
                            iterations,
                            (index) => PathConfiguration(
                              paint: Paint()
                                ..color = Colors.deepOrangeAccent
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..isAntiAlias = true
                                ..strokeCap = StrokeCap.round,
                              path: _trianglePath(
                                  Size(itemSize - (step * index),
                                      itemSize - (step * index)),
                                  itemSize),
                            ),
                          ),
                          ...[
                            PathConfiguration(
                              paint: Paint()
                                ..color = Colors.white
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..isAntiAlias = true
                                ..strokeCap = StrokeCap.round,
                              path: Path()
                                ..moveTo(itemSize / 2, 0)
                                ..lineTo(itemSize / 2, itemSize),
                            ),
                          ]
                        ],
                      ),
                    ),
                    Container(
                      width: itemSize,
                      height: itemSize,
                      color: Colors.black12,
                      child: SimpleAnimatedPathWidget(
                        animation: _anim,
                        size: Size(itemSize, itemSize),
                        configurations: [
                          PathConfiguration(
                            paint: Paint()
                              ..color = Colors.green
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 14
                              ..isAntiAlias = true
                              ..strokeCap = StrokeCap.round,
                            path: _checkBoxPath(itemSize),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Path _checkBoxPath(double itemSize) {
    return Path()
      ..moveTo(0.27083 * itemSize, 0.54167 * itemSize)
      ..lineTo(0.41667 * itemSize, 0.68750 * itemSize)
      ..lineTo(0.75000 * itemSize, 0.35417 * itemSize);
  }

  Path _circlePath(Size size) {
    final dimSize = min(size.width, size.height);
    final r = Radius.circular(max(dimSize / 2, dimSize / 2));
    final w = dimSize;
    final h = dimSize;
    return Path()
      ..moveTo(0, h / 2)
      ..arcToPoint(
        Offset(w, h / 2),
        radius: r,
      )
      ..arcToPoint(
        Offset(0, h / 2),
        radius: r,
      );
  }

  Path _squarePath(Size size) {
    const start = 2.0;
    final dimSize = min(size.width, size.height);
    final w = dimSize - start;
    final h = dimSize - start;
    return Path()
      ..moveTo(start, start)
      ..lineTo(start, w)
      ..lineTo(h, w)
      ..lineTo(h, start)
      ..lineTo(start, start);
  }

  Path _trianglePath(Size size, double panW) {
    const startY = 2.0;
    final dimSize = min(size.width, size.height);
    final h = dimSize;
    final startX = panW / 2;
    return Path()
      ..moveTo(startX, startY)
      ..lineTo(panW - startY, h)
      ..lineTo(startY, h)
      ..lineTo(startX, startY);
  }
}
