import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:flutter_bloc_movies/Constants.dart';
import 'package:flutter_bloc_movies/bloc/movie_details_bloc.dart';
import 'package:flutter_bloc_movies/bloc_providers/movie_details_provider.dart';
import 'package:flutter_bloc_movies/models/tmdb_movie_basic.dart';
import 'package:flutter_bloc_movies/ui/details_page/movie_details_widget.dart';
import 'package:flutter_bloc_movies/utils/ImageHelper.dart';

// ignore: must_be_immutable
class MovieDetailsStreamBuilder extends StatelessWidget {
  final TMDBMovieBasic movie;
  MovieDetailsBloc movieDetailsBloc;

  MovieDetailsStreamBuilder(TMDBMovieBasic this.movie);

  @override
  Widget build(BuildContext context) {
		movieDetailsBloc = MovieDetailsProvider.of(context);
		return StreamBuilder(
				stream: movieDetailsBloc.stream,
				initialData: movieDetailsBloc.initialData(),
				builder: (context, snapshot) {
					final data = snapshot.data;
						return Column(
							children: <Widget>[
								Expanded(
									child: Stack(
										children: <Widget>[
											MovieDetailsWidget(
												hasFailed: data.hasFailed,
												movieDetailsBloc: movieDetailsBloc,
												movieDetails: data.movieDetails
											)

										],
									),
								)
							],
						);
				}
		);
	}
}

Widget getAdvancedNetworkImage(TMDBMovieBasic movie) {
  return new TransitionToImage(AdvancedNetworkImage(posterImagePath(movie)),
      useReload: false, fallbackWidget: SizedBox(height: 300.0));
}

String posterImagePath(TMDBMovieBasic movie) =>
    ImageHelper.getImagePath(movie.posterPath, POSTER_SIZES['small']);

Widget buildPoster(TMDBMovieBasic movie) {
  return getAdvancedNetworkImage(movie);
}
