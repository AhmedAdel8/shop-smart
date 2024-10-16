import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imagepath,
      required this.text,
      required this.function});
  final String imagepath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagepath,
        height: 30,
      ),
      title: SubtitleTextWidget(
        label: text,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
