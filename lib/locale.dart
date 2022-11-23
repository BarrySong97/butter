import 'package:get/get.dart';

class Lang extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'pickThemeColor': 'pick a theme color',
          'pickThemeColorSub': 'pick your favorite color',
          'applyLang': 'Language',
          'applyLangSub': 'switch to your language',
        },
        'zh_CN': {
          'zh_CN': '中文',
          'pickThemeColor': '选取主题色',
          'pickThemeColorSub': '选一个喜欢的颜色吧',
          'applyLang': '应用语言',
          'applyLangSub': '设置本地文字语言信息',
        }
      };
}
