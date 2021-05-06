class ConfigServices {
  late String type;
  late String url;
  late String accessToken;

  static final ConfigServices _instance = ConfigServices._internal();

  factory ConfigServices() => _instance;

  ConfigServices._internal();

  void setConfig(config) {
    type = config['type'];
    url = config['url'];
    accessToken = config['accessToken'];
  }
}