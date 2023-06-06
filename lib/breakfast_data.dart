class Breakfast {
  String name;
  String imgUrl;
  String cookTime;
  String servings;
  String ingredients;
  String instructions;
  String description;

  Breakfast(this.name, this. imgUrl, this.cookTime, this.servings,
      this.ingredients, this.instructions, this.description);

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
}