import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';

void addRoomsheet(
    BuildContext context,
    
    TextEditingController roomNameController,{void Function()? buttononPressed}) {
  final width = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color.fromARGB(255, 29, 29, 35),
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: width * 0.4, right: width * 0.4, top: 7),
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 96, 95, 100),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          CustomTextForm(
              fillColor: const Color.fromARGB(255, 18, 18, 22).withOpacity(0.9),
              hintColor: const Color.fromARGB(255, 96, 95, 100),
              controller: roomNameController,
              labelText: 'Room name'),
          Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(20)),
              width: width * 0.95,
              height: 45,
              child: ElevatedButton(
                onPressed: buttononPressed,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: mainColor,
                    foregroundColor: white),
                child: const Text(
                  'Add Room',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}
