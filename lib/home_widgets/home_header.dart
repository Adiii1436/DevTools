import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: const Text('DevTools',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
              .px4(),
        ),
        Center(
          child: const Text(
            'Toolkit for freaks',
            style: TextStyle(
              fontSize: 15.5,
            ),
          ).px4(),
        )
      ],
    );
  }
}
