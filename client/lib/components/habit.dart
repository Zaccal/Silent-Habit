import 'package:flutter/material.dart';
import 'package:silent_habit/models/post.dart';

const image_url =
    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F000%2F360%2F297%2Foriginal%2Fvector-landscape-illustration.png&f=1&nofb=1&ipt=ba941c91fbcd7b2a299644d0935bcb27283a8d9fd80e7fc9d2f64cc3b01fdaac";

class Habit extends StatelessWidget {
  final Post post;
  const Habit({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      color: Colors.white,
      child: Row(
        children: [
          Image.network(image_url, width: 30, height: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              post.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}