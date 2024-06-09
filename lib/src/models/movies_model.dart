// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';

List<Movies> moviesFromJson(String str) =>
    List<Movies>.from(json.decode(str).map((x) => Movies.fromJson(x)));

String moviesToJson(List<Movies> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movies {
  String? id;
  String? title;
  String? originalTitle;
  String? originalTitleRomanised;
  String? image;
  String? movieBanner;
  String? description;
  String? director;
  String? producer;
  String? releaseDate;
  String? runningTime;
  String? rtScore;
  List<String>? people;
  List<String>? species;
  List<String>? locations;
  List<String>? vehicles;
  String? url;

  Movies({
    this.id,
    this.title,
    this.originalTitle,
    this.originalTitleRomanised,
    this.image,
    this.movieBanner,
    this.description,
    this.director,
    this.producer,
    this.releaseDate,
    this.runningTime,
    this.rtScore,
    this.people,
    this.species,
    this.locations,
    this.vehicles,
    this.url,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        originalTitleRomanised: json["original_title_romanised"],
        image: json["image"],
        movieBanner: json["movie_banner"],
        description: json["description"],
        director: json["director"],
        producer: json["producer"],
        releaseDate: json["release_date"],
        runningTime: json["running_time"],
        rtScore: json["rt_score"],
        people: List<String>.from(json["people"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        locations: List<String>.from(json["locations"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "original_title_romanised": originalTitleRomanised,
        "image": image,
        "movie_banner": movieBanner,
        "description": description,
        "director": director,
        "producer": producer,
        "release_date": releaseDate,
        "running_time": runningTime,
        "rt_score": rtScore,
        "people": List<dynamic>.from(people!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "locations": List<dynamic>.from(locations!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "url": url,
      };
}
