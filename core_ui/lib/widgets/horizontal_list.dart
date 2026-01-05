import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    super.key,
    required this.label,
    required this.itemBuilder,
    required this.itemCount,
  });

  final String label;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: ListView.separated(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }
}
