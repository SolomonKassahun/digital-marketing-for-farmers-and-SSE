// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> oro = {
  "appNameText": "dmfsse",
  "searchText": "barbaaduu",
  "loginText": "seena oomisha",
  "logoutText": "keessaa"
};
static const Map<String,dynamic> en = {
  "appNameText": "dmfsse",
  "searchText": "Search product",
  "loginText": "Log in",
  "logoutText": "Log out"
};
static const Map<String,dynamic> am = {
  "appNameText": "ዲጄታል መገበያያኣ",
  "searchText": "ፍለጋ ምርት",
  "loginText": "ግባ",
  "logoutText": "ውጣ"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"oro": oro, "en": en, "am": am};
}
