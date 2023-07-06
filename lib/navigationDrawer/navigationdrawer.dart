import 'package:adminhuasca/routes/pageroutes.dart';
import 'package:adminhuasca/widgets/create_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            icon: FontAwesomeIcons.check,
            text: '¿Revisar comentarios?',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.comentarios),
          ),
          createDrawerBodyItem(
            icon: FontAwesomeIcons.skullCrossbones,
            text: 'Gestionar lugares',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.lugares),
          ),
          createDrawerBodyItem(
            icon: FontAwesomeIcons.star,
            text: 'Top lugares por calificación',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.top),
          ),
          createDrawerBodyItem(
            icon: FontAwesomeIcons.peopleGroup,
            text: 'Top lugares por visitantes',
            onTap: () => Navigator.pushReplacementNamed(
                context, PageRoutes.visitasLugar),
          ),
          /*       createDrawerBodyItem(
            icon: FontAwesomeIcons.carSide,
            text: 'Medios de transporte',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.top),
          ), */
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
