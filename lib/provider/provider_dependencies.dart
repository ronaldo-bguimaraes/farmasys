import 'package:farmasys/provider/provider_mappers.dart';
import 'package:farmasys/provider/provider_masks.dart';
import 'package:farmasys/provider/provider_repositories.dart';
import 'package:farmasys/provider/provider_services.dart';
import 'package:flutter/material.dart';

// provê em na ordem correta todas as dependencias nescessárias
class ProviderDependencies extends StatelessWidget {
  final Widget child;

  const ProviderDependencies({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderMappers(
      child: ProviderRepositories(
        child: ProviderServices(
          child: ProviderMasks(
            child: child,
          ),
        ),
      ),
    );
  }
}
