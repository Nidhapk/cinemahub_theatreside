import 'package:onlinebooking_theatreside/presentation/screens/Drawer/drawer_items.dart';

import 'package:flutter/material.dart';

BuildContext? context;

final List<ListItem> items = [
  ListItem(icon: Icons.pageview, title: 'Dashborad', onTap: () {}),
  ListItem(icon: Icons.pages, title: 'Rooms', onTap: () {}),
  ListItem(icon: Icons.pageview_outlined, title: 'Bookings', onTap: () {}),
  ListItem(icon: Icons.pageview_outlined, title: 'Profile', onTap: () {}),
  ListItem(icon: Icons.pageview_outlined, title: 'Logout', onTap: () {}),
];
