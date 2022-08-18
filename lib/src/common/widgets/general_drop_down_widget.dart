import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GeneralDropDownButton extends StatelessWidget {
  GeneralDropDownButton(
      {Key? key,
      this.selectedItem,
      required this.itemsList,
      required this.valueChanged})
      : super(key: key);
  String? selectedItem;
  final List<String> itemsList;
  final ValueChanged<String> valueChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ))),
          value: selectedItem ?? itemsList.first,
          items: itemsList
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style:
                        // Style of text inside Drop Down Button

                        TextStyle(
                      fontSize: 15,
                    ),
                  )))
              .toList(),
          onChanged: (item) {
            // setState(() {

            //     selec = item;
            //   });
            valueChanged(item!);
          }),
    );
  }
}
