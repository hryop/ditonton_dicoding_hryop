import 'package:flutter/cupertino.dart';

class EmptyResultWidget extends StatelessWidget {
  final String message;

  const EmptyResultWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(child: Text(message, textAlign: TextAlign.center)),
    );
  }
}
