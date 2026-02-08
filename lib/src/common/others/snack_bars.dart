import 'package:flutter/material.dart';

abstract class SnackBars {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _controller;

  static Widget builder(
    BuildContext context,
    Widget? child, {
    bool withOverlay = true,
  }) {
    final scaffold = Scaffold(
      key: scaffoldKey,
      body: child,
    );

    if (withOverlay) {
      return Overlay(
        initialEntries: [
          OverlayEntry(builder: (_) => scaffold),
        ],
      );
    }

    return scaffold;
  }

  static void remove() {
    return _controller?.close();
  }

  static void show(
    String message, {
    Color? foregroundColor,
    Color? backgroundColor,
    Duration? duration,
    SnackBarAction? action,
  }) {
    final context = scaffoldKey.currentContext;

    if (context == null) return;

    _controller = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: foregroundColor,
          ),
        ),
        backgroundColor: backgroundColor,
        persist: false,
        duration: duration ?? const Duration(seconds: 5),
        action: action,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: foregroundColor,
        dismissDirection: DismissDirection.vertical,
      ),
    );
  }

  static void success(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    return show(
      message,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      duration: duration,
      action: action,
    );
  }

  static void error(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    return show(
      message,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      duration: duration,
      action: action,
    );
  }

  static void warning(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    return show(
      message,
      backgroundColor: Colors.yellow,
      foregroundColor: Colors.black,
      duration: duration,
      action: action,
    );
  }
}
