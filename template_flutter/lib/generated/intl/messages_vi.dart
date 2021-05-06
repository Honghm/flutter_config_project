
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';


  // static m0(day) => "${day} days ago";


  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "languageSuccess": MessageLookupByLibrary.simpleMessage("Cập nhật ngôn ngữ thành công"),
    "vietnamese": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
    "english": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Chế độ ban đêm"),
  };
}
