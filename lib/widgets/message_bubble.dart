import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 220,
        height: 75,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: isMe ? AppColors.dark : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
        ),
      ),
    );
  }
}