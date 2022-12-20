import 'package:faydh/Database/drop_down_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  String hint;
  List listItem;
  String dropDownType;

  DropDown(
      {Key? key,
      required this.hint,
      required this.listItem,
      required this.dropDownType})
      : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? _selectedData;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DropDownProvider>(context);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton(
          alignment: Alignment.centerRight,
          key: UniqueKey(),
          hint: Text(
            widget.hint,
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xff4E4E4E),
                fontWeight: FontWeight.w500),
          ),
          isExpanded: true,
          value: _selectedData,
          onChanged: (newValue) {
            setState(() {
              _selectedData = newValue.toString();
              if (widget.dropDownType == 'city') {
                data.setCity(newValue.toString());
              }
              setState(() {});
            });
          },
          items: widget.listItem.map((valueItem) {
            return DropdownMenuItem(
                value: valueItem, child: Text((valueItem.toString())));
          }).toList(),
        ));
  }
}
