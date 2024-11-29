import 'package:flutter/cupertino.dart';
import 'package:project/helpers/apis.dart';

class Food {
  final String id;
  final String name;
  final String description;
  final ImageProvider image;
  final int timeToCook;
  final double price;
  final double rating;
  late bool isFavourite;
  final String category;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.isFavourite,
    required this.category,
    required this.timeToCook,
    required this.description,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      timeToCook: json['timeToCook'],
      image: NetworkImage("${Apis.publicContentUrl}${json['image']}"),
      price: json['price'],
      rating: json['rating'],
      isFavourite: json['isFavorite'] ?? false,
      category: json['category'],
    );
  }
}

