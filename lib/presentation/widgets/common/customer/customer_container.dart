import 'package:flutter/material.dart';

Widget customerContainer(){
  return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 19, 19, 19),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset:  Offset(2, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 8),
                    child: Container(
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 246, 105, 95),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4 / 2),
                    ),
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.block,
                        color: Color.fromARGB(255, 246, 105, 95),
                        size: 10,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Blocked',
                        style: TextStyle(
                            color: Color.fromARGB(255, 246, 105, 95),
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
                      SizedBox(
                        width: 148,
                      ),
                      Text(
                        'Registered on 01 Apr 24',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(
                      'User name',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'abc@gmail.com',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 0,
                    thickness: 0.7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 240.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'View Details',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        )),
                  )
                ],
              ),
            ),
          );
}