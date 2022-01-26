import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rostik_admin_web/model/config.dart';
import 'package:rostik_admin_web/model/contract.dart';
import 'package:rostik_admin_web/model/module.dart';
import 'package:rostik_admin_web/model/service.dart';
import 'package:rostik_admin_web/model/user.dart';
import 'package:rostik_admin_web/web_storage.dart';

class API {
  String baseUrl = "diplom-glushkov.herokuapp.com";
  String apiStr = "/api/v1/";
  Map<String, String> headers = {};

  Future<Response> getResponse(String params) async {
    Uri url;

    url = Uri.https(baseUrl, "$apiStr$params");

    headers = {
      "Accept": "*/*",
      "Content-type": "application/json; charset=utf-8",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Token " + WebStorage.instance.sessionId
    };

    return await get(url, headers: headers);
  }

  Future<Response> postResponse(String params, String body) async {
    Uri url;

    url = Uri.https(baseUrl, "$apiStr$params");

    headers = {
      "Accept": "*/*",
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      //"Authorization": "Token " + WebStorage.instance.sessionId
    };

    if (WebStorage.instance.sessionId != "")
      headers
          .addAll({"Authorization": "Token " + WebStorage.instance.sessionId});

    return await post(url, headers: headers, body: body);
  }

  Future<Response> deleteResponse(String params) async {
    Uri url;

    url = Uri.https(baseUrl, "$apiStr$params");

    headers = {
      "Accept": "*/*",
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Token " + WebStorage.instance.sessionId
    };

    return await delete(url, headers: headers);
  }

  Future<Response> patchResponse(String params, String body) async {
    Uri url;

    url = Uri.https(baseUrl, "$apiStr$params");

    headers = {
      "Accept": "*/*",
      "Content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Token " + WebStorage.instance.sessionId
    };

    return await patch(url, headers: headers, body: body);
  }

  Future<Map> getTypeService() async {
    Map data = {};
    String params = "service_types/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
    }
    return data;
  }

  Future<Map> postUserLogin(String login, String password) async {
    Map data = {};
    String params = "user/login/";
    var body =
        jsonEncode(<String, String>{'username': login, 'password': password});
    final res = await postResponse(params, body);
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      WebStorage.instance.sessionId = body["key"];
      data = body;
    }
    return data;
  }

  Future<User?> getUserMe() async {
    String params = "user/me/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      WebStorage.instance.userId = body["id"];
      var user = User.fromJson(body);
      return user;
    }
    return null;
  }

  Future<List<Contract>?> getContracts() async {
    String params = "order/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      List<Contract> contracts = [];
      body.forEach((element) {
        contracts.add(Contract.fromJson(element));
      });
      return contracts;
    }
    return null;
  }

  Future<User?> getUser(String id) async {
    String params = "user/$id";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      print(body);
      return User.fromJson(body);
    }
    return null;
  }

  // Future<Contract?>

  Future<List<User>?> getUserList() async {
    String params = "user/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      List<User> users = [];
      body.forEach((element) {
        users.add(User.fromJson(element));
      });
      return users;
    }
    return null;
  }

  Future<List<Config>?> getConfigUser() async {
    String params = "config/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      List<Config> modules = [];
      body.forEach((element) {
        modules.add(Config.fromJson(element));
      });
      return modules;
    }
    return null;
  }

  Future<List<Config>?> getConfigOtherUser(String id) async {
    String params = "user/$id/config/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      List<Config> modules = [];
      body.forEach((element) {
        modules.add(Config.fromJson(element));
      });
      return modules;
    }
    return null;
  }

  Future<List<Service>?> getServices() async {
    String params = "service/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      List<Service> modules = [];
      body.forEach((element) {
        modules.add(Service.fromJson(element));
      });
      return modules;
    }
    return null;
  }

  Future<List<Module>?> getModules() async {
    String params = "module/";
    final res = await getResponse(params);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      List<Module> modules = [];
      body.forEach((element) {
        modules.add(Module.fromJson(element));
      });
      return modules;
    }
    return null;
  }

  Future<Config?> postConfig(String user, String module) async {
    String params = "config/";
    var body = jsonEncode(<String, dynamic>{
      'module': module,
      'user': user,
      'enable': false,
    });
    final res = await postResponse(params, body);
    if (res.statusCode == 201) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      var config = Config.fromJson(body);
      return config;
    }
    return null;
  }

  Future<Config?> patchConfig(String user, String config, bool enable) async {
    String params = "config/$config/";
    var body = jsonEncode(<String, dynamic>{
      'user': user,
      'enable': enable,
    });
    final res = await patchResponse(params, body);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      var config = Config.fromJson(body);
      return config;
    }
    return null;
  }

  Future<bool> deleteConfig(String config) async {
    String params = "config/$config/";
    final res = await deleteResponse(params);
    if (res.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<String?> patchContract(String id, String status) async {
    String params = "order/$id/";
    var body = jsonEncode(<String, dynamic>{
      'status': status,
    });
    final res = await patchResponse(params, body);
    if (res.statusCode == 200) {
      final body = json.decode(utf8.decode(res.bodyBytes));
      String status = body["status"];
      return status;
    }
    return null;
  }
}
