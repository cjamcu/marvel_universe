import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterCacheImage extends StatelessWidget {
  const CharacterCacheImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          size: 50,
          color: Colors.red,
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey,
          height: 230,
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
