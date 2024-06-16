import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:ghibli_app_flutter/src/controllers/movie_controller.dart';
import 'package:ghibli_app_flutter/src/decorators/movies_cache_repository_decorator.dart';
import 'package:ghibli_app_flutter/src/models/movies_model.dart';
import 'package:ghibli_app_flutter/src/repositories/movies_repository_imp.dart';
import 'package:ghibli_app_flutter/src/services/dio_service_imp.dart';
import 'package:ghibli_app_flutter/src/widgets/card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieController _controller = MovieController(
      MoviesCacheRepositoryDecorator(MoviesRepositoryImp(DioServiceImp())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fromCssColor('#141820'),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: fromCssColor('#0A0D10'),
        title: Text(
          'Ghibli Movies',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ValueListenableBuilder<List<Movies>?>(
                  valueListenable: _controller.movies,
                  builder: (_, movies, __) {
                    return Visibility(
                      visible: movies != null,
                      child: TextField(
                          style: TextStyle(color: Colors.grey[400]),
                          onChanged: _controller.onChanged,
                          decoration: InputDecoration(
                              focusColor: fromCssColor('#403369'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[400],
                              ),
                              hintText: 'Search for a ghibli movie...',
                              hintStyle: TextStyle(color: Colors.grey[400]))),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ValueListenableBuilder<List<Movies>?>(
                valueListenable: _controller.movies,
                builder: (_, movies, __) {
                  return movies != null
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.53,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (_, index) {
                            final movie = movies[index];
                            CachedNetworkImage(imageUrl: movie.movieBanner!);
                            return CardWidget(movie: movie);
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'assets/studio-ghibli-logo.svg',
                            semanticsLabel: 'My SVG Image',
                            color: Colors.white,
                            width: 150,
                            height: 150,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
