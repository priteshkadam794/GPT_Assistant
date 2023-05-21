import 'package:flutter/cupertino.dart';
import 'package:youtalk/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Cera Pro",
                    color: Pallete.blackColor),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              descriptionText,
              style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Cera Pro",
                  color: Pallete.mainFontColor),
            )
          ],
        ),
      ),
    );
  }
}
