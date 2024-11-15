import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/common/customer/customer_builder.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/common/customer/customer_container.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return customerBuilder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return customerContainer();
      },
    );
  }
}
