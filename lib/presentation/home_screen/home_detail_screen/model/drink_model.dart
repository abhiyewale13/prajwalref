class DrinkModel {
  final String imageUrl;
  final String title;
  final String price;

  DrinkModel({
    required this.imageUrl,
    required this.title,
    required this.price,
  });
}

List<DrinkModel> drinks = [
  DrinkModel(
    imageUrl: 'assets/home_assets/drink.png',
    title: 'JD Cinamon',
    price: 'AED 1299',
  ),
  DrinkModel(
    imageUrl: 'assets/home_assets/drink.png',
    title: 'Champagne',
    price: 'AED 2499',
  ),
];
