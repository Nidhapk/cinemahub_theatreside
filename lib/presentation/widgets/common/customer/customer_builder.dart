import 'package:flutter/material.dart';

Widget customerBuilder({required int itemCount,required Widget? Function(BuildContext, int) itemBuilder}){
  return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: itemCount,
        itemBuilder: itemBuilder
        );
}