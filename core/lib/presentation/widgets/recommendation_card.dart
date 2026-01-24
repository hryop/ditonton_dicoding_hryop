import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget{
  Function() onTap;
  String posterPath;

  RecommendationCard({super.key, required this.posterPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            imageUrl:
            '$BASE_IMAGE_URL$posterPath',
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          ),
        ),
      ),
    );
  }

}