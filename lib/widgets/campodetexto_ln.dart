import 'package:flutter/material.dart';

class CampoDeTextoLn extends StatelessWidget {
  const CampoDeTextoLn(
      {super.key,
      required this.controler,
      //  this.enabled,
      this.isreadOnly = false,
      required this.label,
      required this.validator,
      this.maximasLineas,
      this.largo,
      this.onCambio,
      this.iconSuffix,
      this.tipoTeclado,
      this.icon});

  final TextEditingController controler;
  final String label;
  // final bool? enabled;
  final int? maximasLineas;
  final int? largo;

  final bool? isreadOnly;
  final Function(String)? onCambio;

  final String? Function(String?)? validator;
  final Widget? icon;
  final Widget? iconSuffix;
  final TextInputType? tipoTeclado;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
          keyboardType: tipoTeclado,
          onChanged: onCambio,
          readOnly: isreadOnly!,
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width >= 600
                  ? MediaQuery.of(context).size.width * .028
                  : 16),
          //  enabled: enabled,
          maxLines: maximasLineas,
          maxLength: largo,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            prefix: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: iconSuffix,
            ),
            label: Text(label),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelStyle: TextStyle(
                color: Colors.yellow,
                fontSize: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * .035
                    : 18),
            //     icon: Icon(FontAwesomeIcons.magnifyingGlass),

            hintText: "Ingresa $label",
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.orange[400]!, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.orange, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
            errorStyle: const TextStyle(color: Colors.red),
            suffixIcon: icon,
          ),
          controller: controler,
          //    keyboardType: TextInputType.phone,
          validator: validator),
    );
  }
}
/////////////////
//////////////
///

