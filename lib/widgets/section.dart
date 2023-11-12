import 'package:flutter/material.dart';
import 'package:wiktionary/constants/numbers.dart';

class Section extends StatefulWidget {
  const Section({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = true,
    this.dividerColor = Colors.transparent,
    this.horizontalPadding = Numbers.defaultHorizontalPadding,
    this.verticalPadding = Numbers.defaultVerticalPadding,
  });

  final String title;
  final List<Widget> content;
  final bool initiallyExpanded;
  final Color dividerColor;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: widget.dividerColor),
          child: ExpansionTile(
            title: Text(widget.title),
            initiallyExpanded: widget.initiallyExpanded,
            children: widget.content,
          ),
        ),
      ),
    );
  }
}
