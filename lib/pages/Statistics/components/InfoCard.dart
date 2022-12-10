import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget extra;
  final Widget content;
  final String? title;

  const InfoCard(
      {this.title, this.extra = const SizedBox(), required this.content});
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      _buildHeader(),
      SizedBox(
        height: 4,
      ),
      _buildContent()
    ];
    if (title == null) {
      children = [_buildContent()];
    }
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: const Color(0xff292929),
            borderRadius: BorderRadius.circular(6)),
        child: Column(children: children));
  }

  Widget _buildHeader() {
    return title != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              extra
            ],
          )
        : Container();
  }

  Widget _buildContent() {
    return content;
  }
}
