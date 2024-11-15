import 'package:flutter/material.dart';

Widget customContainer(
    {required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
    required String title,void Function()? onTap}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 20.0, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            GestureDetector(onTap:onTap ,
              child: Image.asset(
                'assets/pencil (2).png',
                height: 10,
              ),
            )
          ],
        ),
      ),
      Container(
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
            return const Divider(
                height: 0, thickness: 0.7, color: Colors.black);
          },
        ),
      ),
    ],
  );
}
