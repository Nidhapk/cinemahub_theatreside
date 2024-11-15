import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  const HomeAppBar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const  Icon(
              Icons.menu,
              size: 25,
            ));
      }),
      bottom: PreferredSize(
        preferredSize:const Size.fromHeight(1.0),
        child: Container(
          color: Colors.transparent,
          height: 1.0,
          child: Container(
            decoration:const  BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 0.5, 
                ),
              ),
            ),
          ),
        ),
      ),
      title: title,
    );
  }

  @override
  Size get preferredSize =>const  Size.fromHeight(kToolbarHeight);
}
