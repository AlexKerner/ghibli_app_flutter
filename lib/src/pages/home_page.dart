import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:ghibli_app_flutter/src/controllers/movie_controller.dart';
import 'package:ghibli_app_flutter/src/models/movies_model.dart';
import 'package:ghibli_app_flutter/src/repositories/movies_repository_imp.dart';
import 'package:ghibli_app_flutter/src/services/dio_service_imp.dart';
import 'package:ghibli_app_flutter/src/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieController _controller =
      MovieController(MoviesRepositoryImp(DioServiceImp()));

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
                            crossAxisCount: 3, // Número de colunas
                            crossAxisSpacing:
                                8, // Espaço horizontal entre os cards
                            mainAxisSpacing:
                                8, // Espaço vertical entre os cards
                            childAspectRatio:
                                0.53, // Ajuste da proporção do card
                          ),
                          itemCount: movies.length,
                          itemBuilder: (_, index) {
                            return CardWidget(movie: movies[index]);
                          },
                        )
                      : Center(
                          child: SvgPicture.network(
                            'https://upload.wikimedia.org/wikipedia/sco/c/ca/Studio_Ghibli_logo.svg',
                            semanticsLabel: 'My SVG Image',
                            // ignore: deprecated_member_use
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
