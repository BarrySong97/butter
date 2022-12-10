import 'package:flutter/cupertino.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    Key? key,
    required this.size,
    required this.text,
    required this.textColor,
    this.margin: 2.0,
  }) : super(key: key);

  final double size;
  final String text;
  final Color textColor;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 14,
        width: 14,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 10),
        ),
        margin: EdgeInsets.all(margin));
  }
}
