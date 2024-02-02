import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/utils/utils.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class FutureDynamicDropDown extends StatefulWidget {
  const FutureDynamicDropDown({
    super.key,
    required this.label,
    required this.lstItems,
    required this.onChanged,
    this.valorSeleccionado,
  });

  final String label;
  final Future<List<dynamic>> lstItems;
  final Function(String) onChanged;
  final String? valorSeleccionado;

  @override
  State<FutureDynamicDropDown> createState() => _FutureDynamicDropDownState();
}

class _FutureDynamicDropDownState extends State<FutureDynamicDropDown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.lstItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("ErrorssAtDropdown: ${snapshot.error}");
        } else {
          List<DropdownMenuItem<String>> dropdownItems = (snapshot.data ?? <DropdownMenuItem<String>>[])
              .map<DropdownMenuItem<String>>(
                (dynamic option) => DropdownMenuItem<String>(
                  value: option['uid'],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      option['nombre'].toString(),
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
                TextWidget.textLarge(
                  texto: labelToTitulo(
                    widget.label,
                  ),
                  colorTextoDark: ThemeModel().colorPrimario,
                  colorTextoLight: ThemeModel().colorPrimario,
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
      },
    );
  }

  String labelToTitulo(String label) {
    String titulo = '';
    titulo = label;

    return capitalizar(titulo);
  }
}
