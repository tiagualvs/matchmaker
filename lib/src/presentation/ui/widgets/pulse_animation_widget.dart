import 'dart:io';

import 'package:flutter/material.dart';

final testing =
    const bool.fromEnvironment('dart.vm.product') == false &&
    Platform.environment['FLUTTER_TEST'] == 'true';

class PulseAnimationWidget extends StatefulWidget {
  const PulseAnimationWidget({
    super.key,
    this.runningColor = Colors.red,
    this.stopedColor = Colors.grey,
    this.running = true,
    this.duration = const Duration(milliseconds: 300),
  });

  final Color runningColor;
  final Color stopedColor;
  final Duration duration;
  final bool running;

  @override
  State<PulseAnimationWidget> createState() => _PulseAnimationWidgetState();
}

class _PulseAnimationWidgetState extends State<PulseAnimationWidget>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late final forward = Tween<double>(
    begin: 1.0,
    end: 0.5,
  ).animate(controller);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.running && !testing) {
        await controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: forward, curve: Curves.easeInOut),
      alignment: .center,
      child: FadeTransition(
        opacity: CurvedAnimation(parent: forward, curve: Curves.easeInOut),
        child: Icon(
          Icons.circle,
          color: widget.running ? widget.runningColor : widget.stopedColor,
          size: 16.0,
        ),
      ),
    );
  }
}
