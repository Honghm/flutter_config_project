
import 'package:template_flutter/generated/i10n.dart';

class Utils {

  static Function getLanguagesList = ([context]) {
    return [
      {
        "name": context != null ? S.of(context)!.english : "English",
        "icon": "",
        "code": "en",
        "text": "English",
        "storeViewCode": ""
      },
      {
        "name": context != null ? S.of(context)!.vietnamese : "Vietnam",
        "icon":"",
        "code": "vi",
        "text": "Vietnam",
        "storeViewCode": ""
      },

    ];
  };
}