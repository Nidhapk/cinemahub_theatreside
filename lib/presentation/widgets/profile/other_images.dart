import 'package:flutter/material.dart';

Widget otherImagesContainer({required int itemCount,required Widget? Function(BuildContext, int) itemBuilder,required void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Other images'),
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
          height: 180,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 19, 19, 19),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
            shrinkWrap: true,
            itemCount:itemCount,
            itemBuilder: itemBuilder ,
          ),
        ),
      ],
    ),
  );
}
