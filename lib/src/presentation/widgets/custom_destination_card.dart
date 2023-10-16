import 'package:flutter/material.dart';

class CustomDestinationCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String shortDescription;

  const CustomDestinationCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.shortDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4, // Add drop shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
          side: BorderSide(
              color: Colors.grey.shade200, width: 1), // Add border outline
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              // Clip image with curved border
              borderRadius: BorderRadius.circular(5), // Set the border radius
              child: ClipRRect(
                // Clip image with rounded corners
                borderRadius:
                    BorderRadius.circular(16), // Set the border radius
                child: Container(
                  width: 100, // Set desired width
                  height: 100, // Set desired height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1b1e28),
                      ),
                    ),
                    Text(
                      shortDescription,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7c838d),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
