import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final void Function()? action;
  const CustomAppBar({super.key, this.action, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SizedBox(),
          ),
          Text(
            title,
            style: GoogleFonts.notoSansMeroitic(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white70,
            child: IconButton(
              icon: const Icon(
                Icons.bookmarks,
                size: 15,
              ),
              onPressed: action,
            ),
          ),
        ],
      ),
    );
  }
}
