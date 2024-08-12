import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

class LegalCard extends StatefulWidget {
  const LegalCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.tap});
  final IconData icon;
  final String title;
  final String subtitle;
  final Function()? tap;

  @override
  State<LegalCard> createState() => _LegalCardState();
}

class _LegalCardState extends State<LegalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.95, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.tap,
      onTapCancel: widget.tap != null ? _onTapCancel : null,
      onTapDown: widget.tap != null ? _onTapDown : null,
      onTapUp: widget.tap != null ? _onTapUp : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ScaleTransition(
          scale: _animation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: helpCircleBg,
                    child: Icon(widget.icon),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: helpTextColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right_rounded)
            ],
          ),
        ),
      ),
    );
  }
}
