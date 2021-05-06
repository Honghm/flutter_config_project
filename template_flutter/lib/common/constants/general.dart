
/// Logging config
const kLOG_TAG = "[APP]";
const kLOG_ENABLE = false;
const ApiPageSize = 20;

/// enable network proxy
const debugNetworkProxy = false;

/// some constants Local Key
const kLocalKey = {

};
const kAdvanceConfig = {
  "DefaultLanguage": "vi",
  /// set kIsResizeImage to true if you have finish running Re-generate image plugin
  "kIsResizeImage": false,
  "OnBoardOnlyShowFirstTime": true,
  "DefaultCurrency": {"symbol": "đ", "decimalDigits": 0, "symbolBeforeTheNumber": false, "currency": "VND"},
  "Currencies": [
    {"symbol": "đ", "decimalDigits": 0, "symbolBeforeTheNumber": false, "currency": "VND"},
  ],


  ///if  [APP] supports multi languages. set false if [APP] only have one language
  "isMultiLanguages": false
};

void printLog(dynamic data) {
  if (kLOG_ENABLE) {
    // ignore: avoid_print
    print("[${DateTime.now().toUtc()}]$kLOG_TAG${data.toString()}");
  }
}