import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  const BackgroundContainer({
    Key? key,
    required this.child,
    this.backgroundImage = 'assets/images/backgroundGT.jpg', 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño completo
        ),
      ),
      child: child,
    );
  }
}