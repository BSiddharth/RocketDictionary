import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardCachedNetworkMainImage extends StatelessWidget {
  const CardCachedNetworkMainImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      errorWidget: (context, url, error) => Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: const Center(
              child: Icon(
            Icons.error,
            color: Colors.redAccent,
          ))),
    );
  }
}
