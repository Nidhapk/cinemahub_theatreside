import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget customseatGrid(
    {required double height,
    required int itemCount,
    required int crossAxisCount,
    required IndexedWidgetBuilder itemBuilder}) {
  return SizedBox(
    height: height,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: itemBuilder,
      ),
    ),
  );
}
