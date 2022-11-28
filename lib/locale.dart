import 'package:get/get.dart';

class Lang extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'pickThemeColor': 'Theme Color',
          'pickThemeColorSub': 'pick your favorite color',
          'applyLang': 'Language',
          'applyLangSub': 'switch to your language',
          'settingsTitle': 'Settings',
          'habbitsTitle': 'Habbits',
          'addHabit': 'New Habit',
          'addNewHabbit': 'New Habit',
          'cancel': 'Cancel',
          'habbitTitlePlaceHolder': 'Title',
          'done': 'Done'
        },
        'zh_CN': {
          'zh_CN': '中文',
          'cancel': '取消',
          'habbitTitlePlaceHolder': '名称',
          'addNewHabbit': '新习惯',
          'done': '确定',
          'pickThemeColor': '选取主题色',
          'pickThemeColorSub': '选一个喜欢的颜色吧',
          'applyLang': '应用语言',
          'applyLangSub': '设置本地文字语言信息',
          'settingsTitle': '设置',
          'habbitsTitle': '习惯',
          'addHabit': '新习惯',
          'Mon': '一',
          'Tue': '二',
          'Wed': '三',
          'Thu': '四',
          'Fri': '五',
          'Sat': '六',
          'Sun': '日'
        }
      };
}
