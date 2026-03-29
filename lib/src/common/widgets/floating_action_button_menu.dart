import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/extensions/num_ext.dart';

class FloatingActionButtonMenuItem {
  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;

  FloatingActionButtonMenuItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}

class FloatingActionButtonMenu extends StatefulWidget {
  const FloatingActionButtonMenu({
    super.key,
    required this.child,
    required this.menus,
  });

  final Widget child;
  final List<FloatingActionButtonMenuItem> menus;

  @override
  State<FloatingActionButtonMenu> createState() =>
      _FloatingActionButtonMenuState();
}

class _FloatingActionButtonMenuState extends State<FloatingActionButtonMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;
  late final Animation<Offset> position;

  void toggleMenu() async {
    if (controller.isAnimating) return;

    FocusManager.instance.primaryFocus?.unfocus();

    if (controller.isDismissed) {
      await controller.forward();
    } else {
      await controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    position = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          if (!controller.isCompleted) return;

          return await controller.reverse();
        },
        child: Stack(
          children: [
            Positioned.fill(child: widget.child),
            Positioned(
              right: kFloatingActionButtonMargin,
              bottom: kMinInteractiveDimension,
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: SlideTransition(
                  position: position,
                  child: Column(
                    spacing: 2.unit,
                    crossAxisAlignment: .end,
                    children: [
                      for (final menu in widget.menus) ...[
                        FloatingActionButton.extended(
                          heroTag: menu,
                          onPressed: () async {
                            menu.onPressed();
                            return await controller.reverse();
                          },
                          icon: menu.icon,
                          label: menu.label,
                          backgroundColor:
                              context.colorScheme.onPrimaryContainer,
                          foregroundColor: context.colorScheme.primaryContainer,
                        ),
                      ],
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: switch (widget.menus.isEmpty) {
        true => null,
        false => FloatingActionButton(
          onPressed: toggleMenu,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
        ),
      },
    );
  }
}
