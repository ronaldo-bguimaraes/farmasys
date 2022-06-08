import 'package:farmasys/screen/builder/snapshot_builder.dart';
import 'package:farmasys/screen/builder/stream_future_builder.dart';
import 'package:flutter/material.dart';

class StreamFutureSnapshotBuilder<T> extends StatelessWidget {
  final Stream<Future<T>> stream;
  final bool Function(T? data) showChild;
  final Widget Function(BuildContext ctx, T data) builder;

  const StreamFutureSnapshotBuilder({Key? key, required this.stream, required this.showChild, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamFutureBuilder<T>(
      stream: stream,
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
