// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:do_an/api/requestGet.dart';

class ParamChangeInfo {
  String? name, password, address, image, phoneNumber, newPassword, email;
  ParamChangeInfo({
    this.email,
    this.name,
    this.password,
    this.address,
    this.image,
    this.phoneNumber,
    this.newPassword,
  });

  Map<String, String> toMapPhone() {
    return <String, String>{
      'phoneNumber': phoneNumber!,
    };
  }

  Map<String, String> toMapEmail() {
    return <String, String>{
      'email': email!,
    };
  }

  Map<String, String> toMapName() {
    return <String, String>{
      'name': name!,
    };
  }

  Map<String, String> toMapPassword() {
    return <String, String>{
      'password': password!,
      'newPassword': newPassword!,
    };
  }

  Map<String, String> toMapAddress() {
    return <String, String>{
      'address': address!,
    };
  }

  Map<String, String> toMapImage() {
    return <String, String>{
      'image': image!,
    };
  }
}

Future<Map<String, dynamic>> login(
    String email, String password, String param) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/auth/$param',
  );
  final res =
      await http.post(url, body: {"email": email, "password": password});
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result;
  } else if (res.statusCode == 404) {
    final result = jsonDecode(res.body);
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<http.Response> resigter(
    String email, String password, String param) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/auth/$param',
  );
  final res =
      await http.post(url, body: {"email": email, "password": password});
  return res;
}

Future<http.Response> changeInfo(
    Map<String, String> param, String userID, int type) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/auth/${type == 1 ? "change-password" : "change-infor"}',
  );
  final res = await http.post(url, body: param, headers: {"userId": userID});
  return res;
}

Future<Map<String, dynamic>> getOrder(String id) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/order/',
  );
  final res = await http.get(url, headers: {"userId": id});
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<http.Response> changeStatusOrder(String id, String userID) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/order/change-status/id',
  );
  final res = await http
      .put(url, body: {"status": "received"}, headers: {"userId": userID});
  return res;
}
