import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

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
            iconColor: grey,
            onSelected: (value) {
              if (value == 1) {
                editonTap!();
              } else if (value == 2) {
                // Handle Delete action
                deleteonTap!();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Center(
              child: Text(
            text ?? '', style: const TextStyle(color: Colors.grey),
            //   room['roomName'] ?? ''
          )),
        ],
      ),
    ),
  );
}
