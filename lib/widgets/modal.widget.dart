import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({
    Key? key,
    required this.height,
    required this.body,
  }) : super(key: key);

  final double height;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: body,
        ),
      ),
    );
  }
}
