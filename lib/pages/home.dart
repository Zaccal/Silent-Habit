import 'package:flutter/material.dart';
import 'package:silent_habit/components/header.dart';
import 'package:silent_habit/pages/notifications.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(),
          ElevatedButton(
            child: Text("Notifications page"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
