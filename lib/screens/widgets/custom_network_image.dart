import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit? fit;
  const CustomNetworkImage({super.key, required this.image, this.height = 20, this.width = 20, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
