import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundCachedNetworkImage extends StatelessWidget {
  const RoundCachedNetworkImage(
      {Key? key, required this.url, required this.dimension})
      : super(key: key);

  final String url;
  final double dimension;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        width: dimension,
        height: dimension,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
      ),
      errorWidget: (context, url, error) => Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          width: dimension,
          height: dimension,
          child: const Center(
              child: Icon(
            Icons.error,
            color: Colors.redAccent,
          ))),
    );
  }
}
