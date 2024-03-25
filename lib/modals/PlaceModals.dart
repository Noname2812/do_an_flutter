// ignore_for_file: public_member_api_docs, sort_constructors_first

class Province {
  String? id, name;
  Province({
    this.id,
    name,
  });

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: map["ProvinceID"],
      name: map["ProvinceName"],
    );
  }
}

class District {
  String? id, name;
  District({
    this.id,
    name,
  });
  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map["ProvinceID"],
      name: map["DistrictName"],
    );
  }
}

class Ward {
  String? id, name;
  Ward({
    this.id,
    name,
  });
  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: map["WardCode"],
      name: map["WardName"],
    );
  }
}

class ParamGetFee {
  String? height, weight, length;
  String to_district_id, to_ward_code, insurance_value;
  ParamGetFee(
      {this.height,
      this.weight,
      this.length,
      required this.insurance_value,
      required this.to_district_id,
      required this.to_ward_code});
  Map<String, String> toJson() {
    return {
      "from_district_id": "1450",
      "from_ward_code": "20805",
      "service_id": "53320",
      "to_district_id": this.to_district_id,
      "to_ward_code": this.to_ward_code,
      "height": this.height ?? "50",
      "length": this.length ?? "20",
      "weight": this.weight ?? "200",
      "width": "20",
      "insurance_value": this.insurance_value,
      "cod_failed_amount": "100000",
    };
  }
}
