import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final String subTitle;
  final String image;
  final void Function(BuildContext) event;

  const DashboardItem({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.event,
  });
}
