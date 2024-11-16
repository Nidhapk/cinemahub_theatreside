import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

Widget customMovieContainer(
    {required void Function()? onPressed,
    required ImageProvider<Object> image,
    required String movieName,required IconData icon,required void Function()? iconPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: grey),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(2, 1),
          ),
        ],
      ),
      // height: 120,
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
            child: Stack(
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(color:const  Color.fromARGB(255, 58, 58, 58),
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(image: image, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 75,
                  left: 60,
                  child: IconButton(
                    onPressed: iconPressed,
                    icon: Icon(
                      icon,
                      size: 18,
                      color: grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 6.0,
            ),
            child: Text(
              movieName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(
            thickness: 0.5,
            height: 0,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
              height: 30,
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(width: 0.5, color: green)),
                onPressed: onPressed,
                child: const Text(
                  '      VIEW DETAILS     ',
                  style: TextStyle(color: green, fontSize: 7),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
