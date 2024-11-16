import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlinebooking_theatreside/data/models/booking/booking_model.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/sizedbox_one.dart';

Widget bookingContainer(
    {required BuildContext context, required BookingModel bookingModel}) {
  final width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(
          255,
          19,
          19,
          19,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(2, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            // leading: const CircleAvatar(
            //   backgroundColor: Colors.grey,
            // ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.3,
                  ),
                  child: Text(
                    style: TextStyle(
                      color: grey,
                      fontSize: width * 0.03,
                    ),
                    'booked on ${DateFormat('d MMM y, hh:mm a').format(
                      bookingModel.timeStamp.toDate(),
                    )}',
                  ),
                ),
                const SizedboxOne(),
                Text(
                  overflow: TextOverflow.ellipsis,
                  bookingModel.movieName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            subtitle: Text.rich(
              TextSpan(
                text: 'Booked by  ${bookingModel.userEmail}\n\n',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
                children: [
                  TextSpan(
                    text: 'Show Time :${bookingModel.showTime} \n',
                  ),
                  TextSpan(
                    text:
                        'Show Date : ${DateFormat('d MMM y').format(bookingModel.showDate)}\n',
                  ),
                  const TextSpan(text: 'amount : '),
                  TextSpan(
                    text: ('${bookingModel.totalAmount.toInt()} Rs\n'),
                    style: const TextStyle(
                      color: green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 0,
            thickness: 0.7,
          ),
        ],
      ),
    ),
  );
}
