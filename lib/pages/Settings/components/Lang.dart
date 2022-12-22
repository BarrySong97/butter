import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../locale.dart';

var lang = Lang().keys.keys.toList();

void showLanguageSelectDialog(BuildContext context) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(
      context: context,
      builder: (context) => LanguageSelectDialog(
            data: lang,
          ));
}

class LanguageSelectDialog extends StatelessWidget {
  final List<String> data;
  const LanguageSelectDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff292929),
      child: SizedBox(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "chooseLang".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
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

    bool checked = data[index] == l.toString();
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(
        data[index].tr,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => _onSelect(index),
      trailing: checked ? Icon(Icons.check, size: 20, color: color) : null,
    );
  }

  void _onSelect(int index) {
    var l = data[index].split('_');
    var locale = Locale(l[0], l[1]);
    Get.updateLocale(locale);
  }
}
