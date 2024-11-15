import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

Widget seatContainer({
  required void Function()? onDoubleTap,
  required bool emptySeatCondition,
  required bool disAbledSeatCondition,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onDoubleTap: onDoubleTap,
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      color: black,
      child: emptySeatCondition
          ? Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: disAbledSeatCondition ? Colors.grey : white),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: disAbledSeatCondition
                  ? const Icon(
                      Icons.close_rounded,
                      size: 15,
                      color: Colors.grey,
                    )
                  : null,
            )
          : const SizedBox.shrink(),
    ),
  );
}
