import 'package:flutter/material.dart';

class ViewLayout extends StatelessWidget {
  const ViewLayout({
    required this.content,
    required this.action,
    super.key,
  });

  final Widget content;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: content),
          const SizedBox(height: 32),
          action,
        ],
      ),
    );
  }
}
