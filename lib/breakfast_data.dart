class Breakfast {
  String name;
  String phone;
  String imageUrl;
  String type;

  Breakfast(this.name, this.phone, this.imageUrl, this.type);

  String get breakfastName {
    return name;
  }

  String get breakfastPhone {
    return phone;
  }

  String get breakfastImageUrl {
    return imageUrl;
  }

  String get breakfastType {
    return type;
  }
}