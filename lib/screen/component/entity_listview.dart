import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/helper/exclusion_confirmation.dart';
import 'package:flutter/material.dart';

class EntityListView<T extends IEntity> extends StatelessWidget {
  final List<T> items;

  final Widget Function(BuildContext, T) childBuilder;

  final void Function(BuildContext, T) editShow;

  final Future<void> Function(T) removeAction;

  const EntityListView({Key? key, required this.items, required this.childBuilder, required this.editShow, required this.removeAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
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
                        child: childBuilder(ctx, items[index]),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          ExclusionConfirmation.show(
                            ctx: ctx,
                            onAccept: (ctx) async {
                              try {
                                await removeAction(items[index]);
                              }
                              //
                              on ExceptionMessage catch (error) {
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                  SnackBar(
                                    content: Text('Erro: ${error.message}'),
                                    duration: const Duration(milliseconds: 1200),
                                  ),
                                );
                              }
                              //
                               finally {
                                Navigator.of(ctx).pop();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Colors.black26),
              ],
            ),
            color: Colors.white,
          ),
          onTap: () {
            return editShow(ctx, items[index]);
          },
        );
      },
      itemCount: items.length,
      padding: const EdgeInsets.only(bottom: 90),
    );
  }
}
