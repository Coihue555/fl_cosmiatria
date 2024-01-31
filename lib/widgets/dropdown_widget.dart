// ignore_for_file: use_super_parameters

import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/utils/utils.dart';
import 'package:flutter/material.dart';

class DynamicDropDown extends StatefulWidget {
  const DynamicDropDown({
    Key? key,
    required this.label,
    required this.lstItems,
    required this.onChanged,
    this.valorSeleccionado,
  }) : super(key: key);

  final String label;
  final List<String> lstItems;
  final Function(String) onChanged;
  final String? valorSeleccionado;

  @override
  State<DynamicDropDown> createState() => _DynamicDropDownState();
}

class _DynamicDropDownState extends State<DynamicDropDown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = (widget.lstItems)
        .map<DropdownMenuItem<String>>(
          (dynamic option) => DropdownMenuItem<String>(
            value: option,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                option.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        )
        .toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelToTitulo(
              widget.label,
            ),
            style: TextStyle(color: ThemeModel().colorPrimario, fontSize: 17),
          ),
          DropdownButton<String>(
            hint: Text(widget.valorSeleccionado ?? 'Seleccione una opcion'),
            value: selectedItem,
            items: dropdownItems,
            onChanged: (String? selectedValue) {
              selectedItem = selectedValue;
              widget.onChanged.call(selectedItem.toString());
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String labelToTitulo(String label) {
    String titulo = '';
    if (label == 'receptora') {
      titulo = 'Nº Receptora';
    } else if (label == 'horse') {
      titulo = 'Caballo';
    } else {
      titulo = label;
    }

    return capitalizar(titulo);
  }
}
