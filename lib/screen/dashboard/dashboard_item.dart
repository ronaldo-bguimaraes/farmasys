import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final String subTitle;
  final String assetName;
  final void Function(BuildContext) event;

  const DashboardItem({
    required this.title,
    required this.subTitle,
    required this.assetName,
    required this.event,
  });
}
