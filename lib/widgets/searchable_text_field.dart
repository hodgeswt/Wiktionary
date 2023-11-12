import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wiktionary/constants/strings.dart';
import 'package:wiktionary/views/results_view.dart';

class SearchableText extends StatefulWidget {
  const SearchableText({
    super.key,
    this.text = Strings.empty,
  });

  final String text;

  @override
  State<SearchableText> createState() => _SearchableTextState();
}

class _SearchableTextState extends State<SearchableText> {
  String _selection = Strings.empty;

  void _updateSelection(SelectedContent? value) {
    if (value == null || value.plainText.isEmpty) {
      return;
    }

    setState(() {
      _selection = value.plainText;
    });
  }

  void _resultsViewTransition() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsView(
          searchTerm: _selection.toLowerCase(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      contextMenuBuilder: (context, selectableRegionState) {
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: selectableRegionState.contextMenuAnchors,
          buttonItems: <ContextMenuButtonItem>[
            ...selectableRegionState.contextMenuButtonItems,
            ContextMenuButtonItem(
              onPressed: () {
                _resultsViewTransition();
              },
              label: Strings.serachContextText,
            ),
          ],
        );
      },
      onSelectionChanged: _updateSelection,
      child: Text(widget.text),
    );
  }
}
