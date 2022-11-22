import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLanguageSelectDialog(BuildContext context) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(
      context: context,
      builder: (context) => LanguageSelectDialog(
            data: ['中文', 'en_US'],
          ));
}

class LanguageSelectDialog extends StatelessWidget {
  final List<String> data;
  const LanguageSelectDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "选择语言",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: _buildItem,
                itemCount: data.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    Locale? l = Get.locale;
    print(l);
    bool checked = index == 0;
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(data[index]),
      onTap: () => _onSelect(index),
      trailing: checked ? Icon(Icons.check, size: 20, color: color) : null,
    );
  }

  void _onSelect(int index) {
    var locale = Locale('en', 'US');
    Get.updateLocale(locale);
  }
}
