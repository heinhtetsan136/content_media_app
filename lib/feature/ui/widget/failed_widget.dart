import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FailedWidget extends StatelessWidget {
  FailedWidget({
    super.key,
    required this.ref,
    required this.onTry,
  });

  final WidgetRef ref;
  final Function() onTry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Something went wrong"),
          SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              onTry();
            },
            child: Text("Try again"),
          ),
        ],
      ),
    );
  }
}
