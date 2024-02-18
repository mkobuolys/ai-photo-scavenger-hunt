import 'package:flutter/material.dart';

class ViewLayout extends StatelessWidget {
  const ViewLayout({
    required this.content,
    this.header,
    this.footer,
    super.key,
  });

  final Widget content;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (header != null) ...[header!, const SizedBox(height: 32)],
          Expanded(child: content),
          if (footer != null) ...[const SizedBox(height: 32), footer!],
        ],
      ),
    );
  }
}
