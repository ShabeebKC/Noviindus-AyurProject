class AppConfigs{
  static String appToken = "";
  static Map<String, String> headers = {
    "Content-Type": "application/json",
    'Authorization': 'Bearer $appToken',
  };
}