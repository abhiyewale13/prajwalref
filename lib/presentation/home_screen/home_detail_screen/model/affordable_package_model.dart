class AffordablePackageModel {
  final String imageUrl;
  final String title;
  final String price;

  AffordablePackageModel({
    required this.imageUrl,
    required this.title,
    required this.price,
  });
}

List<AffordablePackageModel> affordablePackages = [
  AffordablePackageModel(
    imageUrl: 'assets/home_assets/package.png',
    title: 'Bachelor',
    price: 'AED 1299',
  ),
  AffordablePackageModel(
    imageUrl: 'assets/home_assets/package.png',
    title: 'Family',
    price: 'AED 2499',
  ),
];
