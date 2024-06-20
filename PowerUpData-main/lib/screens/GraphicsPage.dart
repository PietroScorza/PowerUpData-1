import 'package:flutter/material.dart';
import 'package:powerupdata/widgets/PaginasGraphics.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class GraphicsPage extends StatelessWidget {
  final _controller = PageController();
  final List<String> _nombres = lastFourMonths();
  GraphicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 450,
          child: PageView(
            
            reverse: false,
            controller: _controller,
            children: [
              Page1(_nombres[0]),
              Page1(_nombres[1]),
              Page1(_nombres[2]),
              Page1(_nombres[3]),
            ],
          ),
        ),
        SmoothPageIndicator(controller: _controller, count: 4),
        const Padding(padding: EdgeInsets.all(30.0)),
      ],
    ));
  }
}

List<String> lastFourMonths() {
  DateTime fechaActual = DateTime.now();
  List<String> nombres = [];
  List<String> monthNames = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  for (int i = 0; i < 4; i++) {
    DateTime fechaAjustada =
        DateTime(fechaActual.year, fechaActual.month - i, 1);
    int mes = fechaAjustada.month;
    int anio = fechaAjustada.year;
    nombres.add('${monthNames[mes - 1]} $anio');
  }

  return nombres;
}
