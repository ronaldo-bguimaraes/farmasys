import 'package:farmasys/screen/helper/exclusion_confirmation.dart';
import 'package:flutter/material.dart';

class CustomListView<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(BuildContext context, T data) childBuilder;
  final void Function(BuildContext context, T data) onTapEdit;
  final void Function(BuildContext context, T data) onAcceptDelete;

  const CustomListView({Key? key, required this.data, required this.childBuilder, required this.onTapEdit, required this.onAcceptDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: childBuilder(context, data[index]),
                      ),
                      Flexible(
                        flex: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ExclusionConfirmation.show(
                              context: context,
                              onAccept: (context) {
                                onAcceptDelete(context, data[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black26,
                ),
              ],
            ),
            color: Colors.white,
          ),
          onTap: () => onTapEdit(context, data[index]),
        );
      },
      itemCount: data.length,
    );
  }
}
