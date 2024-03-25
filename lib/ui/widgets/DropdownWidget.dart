import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: const Text("Chọn tỉnh/thành"),
      initialSelection: "Option 1", // initially selected value
      dropdownMenuEntries: const [
        DropdownMenuEntry(
          value: "Option 1",
          label: 'abc',
        ),
        DropdownMenuEntry(
          value: "Option 2",
          label: 'abc',
        ),
      ],
      onSelected: (String? newValue) {
        // handle selection change
      },
    );
  }
}
