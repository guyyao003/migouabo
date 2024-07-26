import 'package:flutter/material.dart';

class FlutterFlowCountController extends StatefulWidget {
  const FlutterFlowCountController({
    super.key,
    required this.decrementIconBuilder,
    required this.incrementIconBuilder,
    required this.countBuilder,
    required this.count,
    this.prix,
    required this.updateCount,
    this.stepSize = 1,
    this.minimum,
    this.maximum,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 25.0),
  });

  final Widget Function(bool enabled) decrementIconBuilder;
  final Widget Function(bool enabled) incrementIconBuilder;
  final Widget Function(int count) countBuilder;
  final int count;
  final int? prix;
  final Function(int) updateCount;
  final int stepSize;
  final int? minimum;
  final int? maximum;
  final EdgeInsetsGeometry contentPadding;

  @override
  _FlutterFlowCountControllerState createState() =>
      _FlutterFlowCountControllerState();
}

class _FlutterFlowCountControllerState extends State<FlutterFlowCountController> {
  int get count => widget.count;
  int? get minimum => widget.minimum;
  int? get maximum => widget.maximum;
  int get stepSize => widget.stepSize;
  int get prix => widget.prix!;

  late int totalPrice;

  @override
  void initState() {
    super.initState();
    // Initialize totalPrice based on the initial count
    totalPrice = count * prix;
  }

  bool get canDecrement => minimum == null || count - stepSize >= minimum!;
  bool get canIncrement => maximum == null || count + stepSize <= maximum!;

  void _decrementCounter() {
    if (canDecrement) {
      setState(() {
        widget.updateCount(count - stepSize);
        totalPrice -= prix * stepSize;
        print(totalPrice);
      });
    }
  }

  void _incrementCounter() {
    if (canIncrement) {
      setState(() {
        widget.updateCount(count + stepSize);
        totalPrice += prix * stepSize;
        print(totalPrice);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.contentPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _decrementCounter,
              child: widget.decrementIconBuilder(canDecrement),
            ),
            widget.countBuilder(count),
            InkWell(
              onTap: _incrementCounter,
              child: widget.incrementIconBuilder(canIncrement),
            ),
          ],
        ),
      );
}

