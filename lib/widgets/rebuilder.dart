import 'package:flutter/material.dart';

class Rebuilder extends StatefulWidget {
  const Rebuilder({
    super.key,
    required this.builder,
  });

  final Function(BuildContext) builder;

  @override
  State<Rebuilder> createState() => RebuilderState();

  static RebuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<RebuilderState>()!;
  }
}

class RebuilderState extends State<Rebuilder> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
