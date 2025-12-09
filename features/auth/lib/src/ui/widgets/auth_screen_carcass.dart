import 'package:flutter/material.dart';

class AuthScreenCarcass extends StatelessWidget {
  const AuthScreenCarcass({
    required this.title,
    required this.textFields,
    required this.button,
    required this.authProviders,
    required this.bottomWidget,
    super.key,
  });

  final String title;
  final List<Widget> textFields;
  final Widget button;
  final List<Widget> authProviders;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              Text(title, style: Theme.of(context).textTheme.displaySmall),
              SizedBox(height: 48),
              ...textFields,
              button,
              Divider(),
              Text("or continue with"),
              ...authProviders,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: bottomWidget,
          ),
        ],
      ),
    );
  }
}
