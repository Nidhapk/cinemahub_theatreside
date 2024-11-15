import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

Widget addInterfaceContainer(
    {required String assetName,
    required List<Color> gradientColors,
    required String title,
    required String subTitle,
    required String text,required void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    child: GestureDetector(onTap:onTap ,
      child: Stack(
        children: [
          Container(
            height: 160,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: gradientColors, begin: Alignment.topLeft),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 248, 244, 244).withOpacity(0.5),
                  spreadRadius: 1,
                  offset: const Offset(1, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  opacity: 0.8, image: AssetImage(assetName), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600, color: white),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12, color: white),
                ),
                SizedBox(
                  height: 20,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      foregroundColor: white,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
