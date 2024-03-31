import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SeasonCard extends StatelessWidget {
  final Season season;

  const SeasonCard({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image
          // Image
          SizedBox(
            width: 100,
            height: 150, // Adjust height accordingly
            child: CachedNetworkImage(
              imageUrl: "$BASE_IMAGE_URL${season.posterPath}",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(), // Placeholder widget
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Error widget
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Title
                  Text(
                    season.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Season Number
                  Text(
                    'Season ${season.seasonNumber}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Air Date
                  Text(
                    'Air Date: ${season.airDate}',
                  ),
                  const SizedBox(height: 4.0),
                  // Episode Count
                  Text(
                    'Episode Count: ${season.episodeCount}',
                  ),
                  const SizedBox(height: 4.0),
                  // Rating Bar
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: season.voteAverage / 2,
                        itemCount: 5,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: kMikadoYellow,
                        ),
                        itemSize: 24,
                      ),
                      const SizedBox(width: 8.0),
                      // Vote Average
                      Text('${season.voteAverage}')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
