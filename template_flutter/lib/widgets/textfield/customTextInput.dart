import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

///Ex: AEdD - aCdd - zDasS
class CustomTextInputFormatter extends TextInputFormatter {

  int numberCharsSplit = 4;
  String splitSymbol = " - ";
  CustomTextInputFormatter(this.numberCharsSplit,this.splitSymbol);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      List<String> chars = newValue.text.replaceAll(splitSymbol, '').split('');
      String newString = '';
      for (int i = 0; i < chars.length; i++) {
        if (i % numberCharsSplit == 0 && i != 0) newString += splitSymbol;
        newString += chars[i];
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}


///Auto Upper Chars:
///   input: aBcdEFgh
///   show: ABCDEFGH
class UpperCaseTxt extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class Tools {
  ///Format DateTime to Date
  getDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String converted = DateFormat('dd/MM').format(dateTime);
    return converted;
  }
  ///Format DateTime to Time
  getTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    String converted = DateFormat('hh:mm aaa').format(dateTime);
    return converted;
  }
  ///Format number: 1000000000 -> 1.000.000.000
  numberThousandFormat(number) {
    var formatter = NumberFormat("#,##0", "vi_VN");
    return formatter.format(number);
  }
}