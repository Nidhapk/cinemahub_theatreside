import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/privacy_policy/ui/widgets/sub_content.dart';

Widget subContents({
  required BuildContext context,
  required final List<Map<String, String>> contentItems,
  required int itemCount,
}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: itemCount,
    itemBuilder: (context, index) {
      final item = contentItems[index];
      return subContent(
        title: item['title'] ?? '',
        subtitle: item['subtitle'] ?? '',
      );
    },
  );
}
