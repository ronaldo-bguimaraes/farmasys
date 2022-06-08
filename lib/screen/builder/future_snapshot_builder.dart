import 'package:farmasys/screen/builder/snapshot_builder.dart';
import 'package:flutter/material.dart';

class FutureSnapshotBuilder<T> extends StatelessWidget {
  final Future<T?> future;
  final bool Function(T? data) showChild;
  final Widget Function(BuildContext ctx, T data) builder;

  const FutureSnapshotBuilder({
    Key? key,
    required this.future,
    required this.showChild,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: future,
      builder: (ctx, snapshot) {
        return SnapshotBuilder<T>(
          snapshot: snapshot,
          showChild: showChild,
          builder: builder,
        );
      },
    );
  }
}
