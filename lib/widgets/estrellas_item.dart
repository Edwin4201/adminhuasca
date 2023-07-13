import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EstrellasItem extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final IconData icon4;
  final IconData icon5;
  final double valor;

  const EstrellasItem({
    super.key,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
    required this.icon5,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            color: Colors.blue,
            backgroundColor: Colors.blue[100],
            minHeight: 15,
            value: valor,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon1,
                size: MediaQuery.of(context).size.height * 0.018,
                color: Colors.yellow[800],
              ),
              Icon(
                icon2,
                size: MediaQuery.of(context).size.height * 0.018,
                color: Colors.yellow[800],
              ),
              Icon(
                icon3,
                size: MediaQuery.of(context).size.height * 0.018,
                color: Colors.yellow[800],
              ),
              Icon(
                icon4,
                size: MediaQuery.of(context).size.height * 0.018,
                color: Colors.yellow[800],
              ),
              Icon(
                icon5,
                size: MediaQuery.of(context).size.height * 0.018,
                color: Colors.yellow[800],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${(valor * 100).toStringAsFixed(2)}%",
            style: GoogleFonts.archivoNarrow(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.018,
            ),
          ),
        ),
      ],
    );
  }
}
