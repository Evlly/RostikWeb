
import 'package:universal_html/html.dart';

class WebStorage {

  //Singleton
  WebStorage._internal();
  static final WebStorage instance = WebStorage._internal();
  factory WebStorage() {
    return instance;
  }

  String get sessionId => window.localStorage['SessionId'] ?? "";
  set sessionId(String sid) => (sid == null) ? window.localStorage.remove('SessionId') : window.localStorage['SessionId'] = sid;

  String get userId => window.localStorage['UserId'] ?? "";
  set userId(String uid) => (uid == null) ? window.localStorage.remove('UserId') : window.localStorage['UserId'] = uid;
}