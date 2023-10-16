import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/destination_model.dart';

class DestinationTile extends StatelessWidget {
  final DestinationModel destination;
  const DestinationTile({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(12),
      width: 181,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1eb3bcc8),
            offset: Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            width: double.infinity,
            height: 124,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  destination.images.first,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(4, 0, 10, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    destination.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.1428571429,
                      letterSpacing: 0.5,
                      color: const Color(0xff1b1e28),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    destination.shortDescription,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff7c838d),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            Text(
                              '4.7',
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                letterSpacing: 0.3000000119,
                                color: const Color(0xff1b1e28),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.3333333333,
                            letterSpacing: 0.3000000119,
                            color: const Color(0xff7c838d),
                          ),
                          children: [
                            TextSpan(
                              text: '\$459/',
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333,
                                letterSpacing: 0.3000000119,
                                color: const Color(0xff0d6efd),
                              ),
                            ),
                            TextSpan(
                              text: 'Person',
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                letterSpacing: 0.3000000119,
                                color: const Color(0xff7c838d),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
