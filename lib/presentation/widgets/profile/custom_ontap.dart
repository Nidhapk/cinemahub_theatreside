import 'package:flutter/material.dart';

Widget customOnTapContainer({
  required int itemCount,
  required Widget? Function(BuildContext, int) itemBuilder,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 19, 19),
          borderRadius: BorderRadius.circular(10)),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 0, thickness: 0.7, color: Colors.black);
        },
      ),
    ),
  );
}
