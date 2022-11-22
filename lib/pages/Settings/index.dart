import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'components/Lang.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "设置",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Column(
        children: [buildColorItem(context), buildLocale(context)],
      ),
    );
  }

  Widget buildColorItem(BuildContext context) {
    return ListTile(
      onTap: () => _selectColor(context),
      title: const Text('选取主题色'),
      subtitle: const Text('选一个喜欢的颜色吧'),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget buildLocale(BuildContext context) {
    return ListTile(
      onTap: () => _selectLang(context),
      title: const Text('应用语言'),
      subtitle: const Text('设置本地文字语言信息'),
      trailing: Container(
        width: 24,
        height: 24,
        child: Icon(Icons.language),
      ),
    );
  }

  void _selectLang(BuildContext context) {
    showLanguageSelectDialog(context);
  }

  void _selectColor(BuildContext context) async {
    Color initColor = Theme.of(context).primaryColor;
    final Color newColor = await showColorPickerDialog(
      context,
      initColor,
      title: Text('选择颜色', style: Theme.of(context).textTheme.titleLarge),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,

      // showColorCode: true,
      // colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{ColorPickerType.accent: false},
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      constraints:
          const BoxConstraints(minHeight: 300, minWidth: 320, maxWidth: 320),
    );
  }
}
