class Breakfast {
  String name;
  String imgUrl;
  String cookTime;
  String servings;
  String ingredients;
  String directions;

  Breakfast(this.name, this. imgUrl, this.cookTime, this.servings,
      this.ingredients, this.directions);

  String get breakfastName {
    return name;
  }

  String get breakfastImageUrl {
    return imgUrl;
  }

  String get breakfastCookTime {
    return cookTime;
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