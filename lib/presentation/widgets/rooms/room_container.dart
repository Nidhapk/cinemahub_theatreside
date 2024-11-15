import 'package:flutter/material.dart';

Widget roomContainer(BuildContext context,
    {String? text,
    void Function()? onTap,
    required void Function()? deleteonTap,
    required void Function()? editonTap}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height * 0.22,
      width: width * 0.3,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 39, 38, 43),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                editonTap!();
                print('Edit selected');
              } else if (value == 2) {
                // Handle Delete action
                deleteonTap!();
                print('Delete selected');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Edit'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Delete'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Center(
              child: Text(text ?? ''
                  //   room['roomName'] ?? ''
                  )),
        ],
      ),
    ),
  );
}
