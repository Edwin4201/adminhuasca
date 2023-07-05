import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:adminhuasca/widgets/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ComentariosScreen extends StatelessWidget {
  static const String routeName = '/Comentarios';

  const ComentariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        shadowColor: Colors.black,
        title: Text("1,765 Restantes"),
      ),
      drawer: Navigationdrawer(),
      body: ListView(
        children: [
          ComentarioItem(),
          ComentarioItem(),
        ],
      ),
    );
  }
}

class ComentarioItem extends StatelessWidget {
  const ComentarioItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          border: Border.all()),
      child: Column(
        children: [
          Text(
            "Bosque encantado",
            style: GoogleFonts.spaceGrotesk(color: Colors.green),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "24/06/95",
                    style: GoogleFonts.spaceGrotesk(color: Colors.green),
                  ),
                  Text(
                    "10:00:00",
                    style: GoogleFonts.spaceGrotesk(color: Colors.green),
                  ),
                ],
              ),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: 3,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  FontAwesomeIcons.star,
                  color: Colors.lightGreenAccent,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 5,
          ),
          Text(
            "# 343",
            style: GoogleFonts.spaceGrotesk(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop .",
            style: GoogleFonts.spaceGrotesk(color: Colors.green),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    mostrarAlerta(context, "¡Atención!",
                        "Desea rechazar este comentario?", "Aceptar", () {
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Rechazar",
                    style: GoogleFonts.spaceGrotesk(color: Colors.red),
                  )),
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    mostrarAlerta(context, "¡Atención!",
                        "Desea aceptar este comentario?", "Aceptar", () {
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  ),
                  label: Text(
                    "Aceptar",
                    style: GoogleFonts.spaceGrotesk(color: Colors.green),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
