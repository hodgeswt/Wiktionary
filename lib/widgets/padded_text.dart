import 'package:flutter/material.dart';
import 'package:wiktionary/constants/numbers.dart';

class PaddedText extends StatelessWidget {
  const PaddedText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Numbers.defaultHorizontalPadding,
        vertical: Numbers.defaultVerticalPadding,
      ),
      child: Text(
        text,
      ),
    );
  }
}
