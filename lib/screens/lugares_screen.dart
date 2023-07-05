import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:adminhuasca/widgets/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
          foregroundColor: Colors.white,
          shadowColor: Colors.black,
          title: Text("gestionar lugares")),
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
            "Agregar un nuevo lugar",
            "Agregar",
            () {},
          );
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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
          color: Colors.white,
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
                child: Text("32987"),
                radius: 40,
              ),
              Column(
                children: [
                  Text("Huasca"),
                  Text("Hidalgo"),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                      "centro ecoturistico el bosque de las truchas kjrew ekjrewjk rkejrh"))
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
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Expanded(child: Text("10,72727\n visitas"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    mostrarAlerta(
                        context,
                        "¡No tocar!",
                        "Usar esta función solo para emergencias",
                        "Borrar",
                        () {});
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Borrar")),
              FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    mostrarAlerta(
                        context,
                        "¡No tocar!",
                        "Usar esta función solo para emergencias",
                        "Editar",
                        () {});
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Editar"))
            ],
          ),
        ],
      ),
    );
  }
}
