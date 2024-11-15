import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

Widget addRoomContainer({void Function()? onTap}){
                            return GestureDetector(
                           onTap: onTap,
                            child: DottedBorder(
                              color: white,
                              dashPattern: const [6, 3],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(20),
                              child: Container(
                                // height: height * 0.22,
                                // width: width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(child: Icon(Icons.add)),
                              ),
                            ),
                          );
}