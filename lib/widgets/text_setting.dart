import 'package:flutter/material.dart';

class TextSetting extends StatefulWidget {
  const TextSetting({
    super.key,
    required this.labelText,
    required this.controller,
    required this.onChanged,
    required this.validator,
  });

  final String labelText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  @override
  State<TextSetting> createState() => TextSettingState();

  static TextSettingState of(BuildContext context) {
    return context.findAncestorStateOfType<TextSettingState>()!;
  }
}

class TextSettingState extends State<TextSetting> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Text(widget.labelText),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: widget.onChanged,
                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: Numbers.defaultHorizontalPadding,
    //     vertical: Numbers.defaultVerticalPadding,
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       Expanded(
    //         child: Text(
    //           widget.labelText,
    //         ),
    //       ),
    //       Expanded(
    //         child: TextField(
    //           controller: widget.controller,
    //           decoration: const InputDecoration(
    //             border: OutlineInputBorder(),
    //           ),
    //           onChanged: widget.onChanged,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
