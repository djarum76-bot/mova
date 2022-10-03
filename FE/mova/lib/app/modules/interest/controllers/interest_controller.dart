import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestController extends GetxController {
  List<String> genreList = [
    "Action",
    "Drama",
    "Comedy",
    "Horror",
    "Adventure",
    "Thriller",
    "Romance",
    "Science",
    "Music",
    "Documentary",
    "Crime",
    "Fantasy",
    "Mistery",
    "Fiction",
    "War",
    "History",
    "Superheroes",
    "Sport",
  ];

  final selected = <String>[].obs;
}
