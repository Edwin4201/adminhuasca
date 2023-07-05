import 'package:adminhuasca/routes/pageroutes.dart';
import 'package:adminhuasca/widgets/create_drawer_header.dart';
import 'package:flutter/material.dart';

import '../widgets/create_drawer_body_item.dart';

class Navigationdrawer extends StatelessWidget {
  const Navigationdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        //cambiar por conteiner para poner color
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.check,
            text: '¿Revisar comentarios?',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.comentarios),
          ),
          createDrawerBodyItem(
            icon: Icons.dangerous,
            text: 'Gestionar lugares',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.lugares),
          ),
          createDrawerBodyItem(
            icon: Icons.restaurant,
            text: '¿Top lugares por calificación?',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.top),
          ),
          createDrawerBodyItem(
            icon: Icons.hotel,
            text: 'Top lugares por numero de visitas',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.top),
          ),
          createDrawerBodyItem(
            icon: Icons.emergency,
            text: 'Medios de transporte',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.top),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
