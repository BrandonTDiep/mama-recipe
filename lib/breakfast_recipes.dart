import 'package:flutter/material.dart';
import 'breakfast_data.dart';

class BreakfastRecipesPage extends StatefulWidget {
  final Breakfast breakfast;

  BreakfastRecipesPage(this.breakfast);

  @override
  State<BreakfastRecipesPage> createState() => _BreakfastRecipesPageState();
}

class _BreakfastRecipesPageState extends State<BreakfastRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(widget.breakfast.name),
          Text(widget.breakfast.phone),
          Text(widget.breakfast.type),
          Text(widget.breakfast.imageUrl),
        ],
      ),
    );
  }
}
