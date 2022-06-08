import 'package:flutter/material.dart';

class StreamFutureBuilder<T> extends StatelessWidget {
  final Stream<Future<T>> stream;
  final AsyncWidgetBuilder<T> builder;

  const StreamFutureBuilder({
    Key? key,
    required this.stream,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Future<T>>(
      stream: stream,
      builder: (ctx, snapshot) {
        return FutureBuilder<T>(
          future: snapshot.data,
          builder: builder,
        );
      },
    );
  }
}
