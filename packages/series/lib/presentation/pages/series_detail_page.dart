import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:series/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/presentation/widgets/season_card.dart';

class SeriesDetailPage extends StatelessWidget {
  static const routeName = '/detail-series';
  final int id;
  final GetIt locator;

  const SeriesDetailPage({super.key, required this.id, required this.locator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => locator<SeriesDetailBloc>()
          ..add(
            FetchSeriesDetailEvent(tID: id),
          ),
        child: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
          builder: (context, state) {
            if (state is SeriesDetailFailed) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is SeriesDetailLoaded) {
              final serie = state.seriesDetail;
              return SafeArea(
                child: BlocProvider(
                  create: (context) => locator<SeriesDetailBloc>(),
                  child: DetailContent(
                    serie,
                    locator: locator,
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final SeriesDetail serie;
  final GetIt locator;

  const DetailContent(this.serie, {super.key, required this.locator});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isWatchlist = false;

  void onChangeWatchlist(isWatchList, BuildContext context) {
    if (!isWatchList) {
      context
          .read<SeriesDetailBloc>()
          .add(SaveWatchlistEvent(serie: widget.serie));
    } else {
      context
          .read<SeriesDetailBloc>()
          .add(RemoveWatchlistEvent(serie: widget.serie));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<SeriesDetailBloc>().add(
          GetWatchlistStatusEvent(
            tID: widget.serie.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<SeriesDetailBloc, SeriesDetailState>(
      listener: (context, state) {
        if (state is WatchlistChangeSuccess) {
          if (state.message == SeriesDetailBloc.watchlistAddSuccessMessage ||
              state.message == SeriesDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              },
            );
          }
        }

        if (state is WatchlistStatusLoaded) {
          setState(() {
            isWatchlist = state.isWatchlist;
          });
        }
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/w500${widget.serie.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.serie.name,
                                style: kHeading5,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  onChangeWatchlist(isWatchlist, context);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              ),
                              Text(
                                _showGenres(widget.serie.genres),
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: widget.serie.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${widget.serie.voteAverage}')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                widget.serie.overview,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              RecommendationSection(
                                locator: locator,
                                seriesId: widget.serie.id,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Seasons',
                                style: kHeading6,
                              ),
                              SeriesSeasons(serie: widget.serie),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.25,
              // maxChildSize: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class RecommendationSection extends StatelessWidget {
  final GetIt locator;
  final int seriesId;
  const RecommendationSection({
    super.key,
    required this.locator,
    required this.seriesId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => locator<SeriesDetailBloc>()
          ..add(
            FetchSeriesRecommendationsEvent(
              tID: seriesId,
            ),
          ),
        child: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
          builder: (context, state) {
            if (state is SeriesRecommendationLoaded) {
              return RecommendationSeries(
                recommendations: state.recommendationSeries,
              );
            }

            if (state is SeriesDetailFailed) {
              return Text(state.error);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class RecommendationSeries extends StatelessWidget {
  const RecommendationSeries({
    super.key,
    required this.recommendations,
  });

  final List<Series> recommendations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final serie = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  SeriesDetailPage.routeName,
                  arguments: serie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${serie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: recommendations.length,
      ),
    );
  }
}

class SeriesSeasons extends StatelessWidget {
  const SeriesSeasons({
    super.key,
    required this.serie,
  });

  final SeriesDetail serie;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: serie.seasons.length,
      itemBuilder: (BuildContext context, int index) {
        return SeasonCard(season: serie.seasons[index]);
      },
    );
  }
}
