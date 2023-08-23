import 'package:flutter/material.dart';

class CancelSaveButton extends StatelessWidget {
  const CancelSaveButton(
      {super.key,
      required this.title,
      required this.buttonColor,
      required this.titleColor,
      required this.width,
      this.onTap});
  final String title;
  final Color buttonColor;
  final Color titleColor;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap!();
        },
        child: Container(
          width: width,
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: width,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
