import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:adminhuasca/widgets/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        foregroundColor: Colors.white,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all()),
      child: Column(
        children: [
          Text("Bosque encantado"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("24/06/95"),
                  Text("10:00:00"),
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
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
          Divider(),
          Text(
            "# 343",
            textAlign: TextAlign.left,
          ),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop ."),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: Text("Rechazar")),
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    mostrarAlerta(context, "¡Atención!",
                        "Desea aceptar este comentario?", "Aceptar", () {});
                  },
                  icon: Icon(Icons.check_circle),
                  label: Text("Aceptar")),
            ],
          )
        ],
      ),
    );
  }
}
