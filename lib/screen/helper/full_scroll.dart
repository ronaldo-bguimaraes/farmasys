import 'package:flutter/material.dart';

class FullScroll extends StatelessWidget {
  final Widget child;
  
  const FullScroll({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            child: child,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
          ),
        );
      },
    );
  }
}
