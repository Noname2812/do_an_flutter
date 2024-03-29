import 'package:do_an/api/giaoHangNhanhApi.dart';
import 'package:do_an/modals/PlaceModals.dart';
import 'package:flutter/material.dart';

const LABEL_CHOICES = ["Chọn tỉnh/thành", "Chọn quận/huyện", "Chọn phường/xã"];

// ignore: must_be_immutable
class DropdownWidget extends StatefulWidget {
  DropdownWidget(
      {super.key,
      required this.type,
      this.provinceID,
      this.districtID,
      required this.function});
  int type;
  String? provinceID, districtID;
  Function function;
  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  List<dynamic> data = [];
  String? _value1;
  @override
  void didUpdateWidget(covariant DropdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.provinceID != widget.provinceID ||
        oldWidget.districtID != widget.districtID) {
      data = [];
      _value1 = null;
      getData();
    }
  }

  void getData() async {
    if (widget.type == 0) {
      final res = await getProvinces();
      setState(() {
        data = res.map((e) => Province.fromMap(e)).toList();
      });
    } else if (widget.type == 1) {
      final res = await getDistricts(widget.provinceID!);
      setState(() {
        data = res.map((e) => District.fromMap(e)).toList();
      });
    } else if (widget.type == 2) {
      final res = await getWards(widget.districtID!);
      setState(() {
        data = res.map((e) => Ward.fromMap(e)).toList();
      });
    }
  }

  String? _validateSelection(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a value';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    void handleChoice(String value) {
      widget.function(value);
      setState(() {
        _value1 = value;
      });
    }

    return DropdownButtonFormField<dynamic>(
      value: _value1,
      isExpanded: true,
      validator: (value) => _validateSelection(value),
      items: data
          .map((e) => DropdownMenuItem<dynamic>(
                value: e.id.toString(),
                child: Text(e.name.toString()),
              ))
          .toList(),
      onChanged: (dynamic newValue) => handleChoice(newValue),
      hint: Text(LABEL_CHOICES[widget.type]),
    );
  }
}
