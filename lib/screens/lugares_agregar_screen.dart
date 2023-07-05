import 'package:adminhuasca/services/estados_service.dart';
import 'package:adminhuasca/widgets/campodetexto_ln.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/mostrar_alerta.dart';

class LugaresAgregarScreen extends StatefulWidget {
  const LugaresAgregarScreen({super.key});

  @override
  State<LugaresAgregarScreen> createState() => _LugaresAgregarScreenState();
}

class _LugaresAgregarScreenState extends State<LugaresAgregarScreen> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController estadoCtrl = TextEditingController();
  //
  bool _switchValueMexico = true;

  @override
  Widget build(BuildContext context) {
    final estadosService = Provider.of<EstadosService>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        title: Text("Agregar nuevo lugar"),
      ),
      body: ListView(
        children: [
          CampoDeTextoLn(
            controler: idCtrl,
            label: "ID",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "ID del lugar";
              }
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return "solo números.";
              }
              if (value.contains(" ")) {
                return "No puede contener espacios.";
              }
              return null;
            },
          ),
          CampoDeTextoLn(
            largo: 79,
            controler: idCtrl,
            label: "NOMBRE",
            validator: (value) {
              return;
            },
          ),
          //estado
          _switchValueMexico == false
              ? Container()
              : CampoDeTextoLn(
                  icon: PopupMenuButton(
                      onSelected: (value) {
                        setState(() {
                          if (!mounted) return;

                          estadoCtrl.text = value.toString();
                        });
                      },
                      color: Colors.white,
                      icon: const Icon(
                        FontAwesomeIcons.caretDown,
                        color: Colors.blue,
                      ),
                      itemBuilder: (context) => List.generate(
                            estadosService.estados[0].response.length,
                            (index) => PopupMenuItem(
                                value: estadosService
                                    .estados[0].response[index].nombreEstado,
                                child: Text(
                                    estadosService.estados[0].response[index]
                                        .nombreEstado,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >=
                                                    600
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04
                                                : 18))),
                          )),
                  isreadOnly: true,
                  controler: estadoCtrl,
                  label: "¿Seleccione su estado?",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Favor de seleccionar una opción";
                    }

                    return null;
                  },
                ),
          FilledButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              onPressed: () {
                mostrarAlerta(context, "¡Atención!",
                    "Desea Agregar este lugar?", "Agregar", () {
                  Navigator.of(context, rootNavigator: true).pop();
                });
              },
              icon: Icon(
                FontAwesomeIcons.check,
                color: Colors.white,
              ),
              label: Text(
                "Agregar",
                style: GoogleFonts.spaceGrotesk(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
