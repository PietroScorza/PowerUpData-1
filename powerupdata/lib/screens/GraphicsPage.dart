import 'package:flutter/material.dart';
import 'package:powerupdata/widgets/PaginasGraphics.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GraphicsPage extends StatelessWidget {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 450,
            child: PageView(
              controller: _controller,
              children: const [
                Page1(),
                Page1()
            ],),
          ),
          SmoothPageIndicator(controller: _controller, count: 2),
          Padding( padding: const EdgeInsets.all(30.0)),
        ],
      )
    );
  }
}