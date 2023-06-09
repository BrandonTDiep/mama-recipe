class Breakfast {
  String name;
  String imgUrl;
  String time;
  String servings;
  String ingredients;
  String directions;

  Breakfast(this.name, this. imgUrl, this.time, this.servings,
      this.ingredients, this.directions);

  String get breakfastName {
    return name;
  }

  String get breakfastImageUrl {
    return imgUrl;
  }

  String get breakfastCookTime {
    return time;
  }

  String get breakfastServings {
    return servings;
  }

  String get breakfastIngredients {
    return ingredients;
  }

  String get breakfastDirections {
    return directions;
  }
}