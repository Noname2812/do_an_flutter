// ignore_for_file: public_member_api_docs, sort_constructors_first

class Province {
  String? name;
  int? id;
  Province({
    this.id,
    this.name,
  });

  factory Province.fromMap(dynamic map) {
    return Province(
      id: map["ProvinceID"],
      name: map["ProvinceName"],
    );
  }
}

class District {
  String? name;
  int? id;
  District({
    this.id,
    this.name,
  });
  factory District.fromMap(dynamic map) {
    return District(
      id: map["DistrictID"],
      name: map["DistrictName"],
    );
  }
}

class Ward {
  String? name;
  String? id;
  Ward({
    this.id,
    this.name,
  });
  factory Ward.fromMap(dynamic map) {
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
      "from_district_id": "1454",
      "from_ward_code": "21211",
      "to_district_id": this.to_district_id,
      "to_ward_code": this.to_ward_code,
      "insurance_value": this.insurance_value,
      "cod_failed_amount": "100000",
      "height": "50",
      "length": "20",
      "weight": "200",
      "width": "20",
    };
  }
}
