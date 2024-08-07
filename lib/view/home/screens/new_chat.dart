import 'package:flutter/material.dart';

class NewChat extends StatelessWidget {
  const NewChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 30,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: 100,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
