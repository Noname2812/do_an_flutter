import 'dart:convert';

import 'package:do_an/modals/PlaceModals.dart';
import 'package:http/http.dart' as http;

const baseURL = 'https://online-gateway.ghn.vn/shiip/public-api/master-data';
const headers = {
  "token": "790853c2-d6d5-11ee-b38e-f6f098158c7e",
  "shop_id": '4925558'
};

Future<Map<String, dynamic>> getProvinces() async {
  final url = Uri.https(baseURL, '/province');
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getDistricts(String id) async {
  final url = Uri.https(baseURL, '/district', {"province_id": id});
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getWards(String id) async {
  final url = Uri.https(baseURL, '/ward', {"district_id": id});
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getFee(ParamGetFee param) async {
  final url = Uri.https(
      'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order',
      '/fee',
      param.toJson());
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}
