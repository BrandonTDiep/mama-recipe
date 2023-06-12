import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  void Function()? onTap;
  FavoriteButton({super.key, required this.isFavorite, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isFavorite ? Icons.favorite: Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
    );
  }
}


