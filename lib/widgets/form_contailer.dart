import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({super.key, required this.child, required this.width});
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      width: width,
      height: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: child
    );
  }
}
