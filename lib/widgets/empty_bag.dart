import 'package:flutter/material.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';
import 'package:shopsmart/widgets/title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget(
      {super.key,
      required this.imagepath,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  final String imagepath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagepath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const TitleTextWidget(
              label: 'Whoops',
              fontsize: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
            SubtitleTextWidget(
              label: title,
              fontWeight: FontWeight.w600,
              fontsize: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleTextWidget(
                label: subtitle,
                fontWeight: FontWeight.w400,
                fontsize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(20),
                elevation: 0,
              ),
              onPressed: () {},
              child: Text(
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
                buttonText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
