import 'package:flutter/material.dart';

class SnapshotBuilder<T> extends StatelessWidget {
  final AsyncSnapshot<T?> snapshot;
  final bool Function(T? data) showChild;
  final Widget Function(BuildContext ctx, T data) builder;

  const SnapshotBuilder({
    Key? key,
    required this.snapshot,
    required this.showChild,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    //
    else if (showChild(snapshot.data)) {
      return builder(
        context,
        snapshot.data!,
      );
    }
    //
    return const Scaffold(
      body: Center(
        child: Text("Não há dados disponíveis"),
      ),
    );
  }
}
