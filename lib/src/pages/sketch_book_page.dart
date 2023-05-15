import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPainterPage extends StatefulWidget {
  const CustomPainterPage({super.key});

  @override
  State<CustomPainterPage> createState() => _CustomPainterPageState();
}

class _CustomPainterPageState extends State<CustomPainterPage> {
  final List<dynamic> _offsets = [];

  double? strokeWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    log(_offsets.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sketch book"),
        elevation: 4,
        actions: [
          IconButton.filledTonal(
            onPressed: _offsets.isNotEmpty
                ? () {
                    _offsets.clear();
                  }
                : null,
            icon: const Icon(Icons.clear_sharp),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanDown: (details) {
                setState(() {
                  _offsets.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _offsets.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _offsets.add(null);
                });
              },
              child: Center(
                child: CustomPaint(
                  painter: ShapePainter(_offsets, strokeWidth!),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Slider(
              max: 10,
              divisions: 5,
              value: strokeWidth!,
              onChanged: (newVal) {
                setState(() {
                  strokeWidth = newVal;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final List<dynamic> offsets;
  final double strokeWidth;

  ShapePainter(this.offsets, this.strokeWidth) : super();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        canvas.drawLine(offsets[i], offsets[i + 1], paint);
      } else if (offsets[i] != null && offsets[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [offsets[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
