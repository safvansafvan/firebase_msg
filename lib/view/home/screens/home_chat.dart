import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({
    super.key,
  });

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.isScrollingNotifier.value) {
      phoneVibration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        children: [
          TextField(
            cursorColor: Colors.black87,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20),
              hintText: 'Search...',
              fillColor: Colors.grey[300],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                  ),
                );
              },
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
          )
        ],
      ),
    );
  }
}
