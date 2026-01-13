import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Today', style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}
