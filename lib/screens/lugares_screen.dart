import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:adminhuasca/widgets/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class LugaresScreen extends StatefulWidget {
  static const String routeName = '/Lugares';

  const LugaresScreen({super.key});

  @override
  State<LugaresScreen> createState() => _LugaresScreenState();
}

class _LugaresScreenState extends State<LugaresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          foregroundColor: Colors.green,
          shadowColor: Colors.black,
          title: Text("Gestionar lugares")),
      drawer: Navigationdrawer(),
      body: ListView(
        children: [
          LugarItem(),
          LugarItem(),
          LugarItem(),
          LugarItem(),
          LugarItem(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          mostrarAlerta(
            context,
            "¡Atención!",
            "Agregar un nuevo lugar cuidadosamente",
            "Agregar",
            () {
              Navigator.pushNamed(context, "agregarlugar");
            },
          );
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
      ),
    );
  }
}

class LugarItem extends StatelessWidget {
  const LugarItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          border: Border.all()),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: Text(
                  "32987",
                  style:
                      GoogleFonts.spaceGrotesk(color: Colors.lightGreenAccent),
                ),
                radius: 40,
              ),
              Column(
                children: [
                  Text(
                    "Huasca   ",
                    style: GoogleFonts.spaceGrotesk(color: Colors.green),
                  ),
                  Text(
                    "Hidalgo  ",
                    style: GoogleFonts.spaceGrotesk(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "centro ecoturistico el bosque de las truchas kjrew ekjrewjk rkejrh",
                style: GoogleFonts.spaceGrotesk(color: Colors.green),
              ))
            ],
          ),
          Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: 3,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.lightGreenAccent,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Expanded(
                  child: Text(
                "10,72727\n visitas",
                style: GoogleFonts.spaceGrotesk(color: Colors.green),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    mostrarAlerta(
                        context,
                        "¡No tocar!",
                        "Usar esta función solo para emergencias",
                        "Borrar",
                        () {});
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Borrar",
                    style: GoogleFonts.spaceGrotesk(color: Colors.red),
                  )),
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    mostrarAlerta(
                        context,
                        "¡No tocar!",
                        "Usar esta función solo para emergencias",
                        "Editar",
                        () {});
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                  label: Text(
                    "Editar",
                    style: GoogleFonts.spaceGrotesk(color: Colors.green),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
