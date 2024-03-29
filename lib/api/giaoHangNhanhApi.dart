import 'dart:convert';

import 'package:do_an/modals/PlaceModals.dart';
import 'package:http/http.dart' as http;

const baseURL = 'online-gateway.ghn.vn';
const headers = {
  "token": "790853c2-d6d5-11ee-b38e-f6f098158c7e",
  "shop_id": '4925558'
};

Future<List<dynamic>> getProvinces() async {
  final url = Uri.https(baseURL, '/shiip/public-api/master-data/province');

  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result["data"];
  } else {
    throw Exception("Call api falied !");
  }
}

Future<List<dynamic>> getDistricts(String id) async {
  final url = Uri.https(
      baseURL, '/shiip/public-api/master-data/district', {"province_id": id});
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result["data"];
  } else {
    throw Exception("Call api falied !");
  }
}

Future<List<dynamic>> getWards(String id) async {
  final url = Uri.https(
      baseURL, '/shiip/public-api/master-data/ward', {"district_id": id});
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result["data"];
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getFee(ParamGetFee param) async {
  String? service_id = await getServiceID(param.to_district_id);
  final url = Uri.https(
      'online-gateway.ghn.vn',
      '/shiip/public-api/v2/shipping-order/fee',
      {...param.toJson(), "service_id": service_id});
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result["data"];
  } else {
    throw Exception("Call api falied !");
  }
}

Future<String> getServiceID(String id) async {
  final url = Uri.https(
      'online-gateway.ghn.vn',
      '/shiip/public-api/v2/shipping-order/available-services',
      {"from_district": "1454", "to_district": id, "shop_id": "4925558"});
  final res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    final data = result["data"];
    return data[0]["service_id"].toString();
  } else {
    throw Exception("Call api falied !");
  }
}
