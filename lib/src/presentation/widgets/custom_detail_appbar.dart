import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetailAppBar extends StatelessWidget {
  final String title;
  final void Function()? action;
  const CustomDetailAppBar({super.key, this.action, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white70,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.notoSansMeroitic(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
