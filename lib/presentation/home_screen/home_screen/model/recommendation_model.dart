class RecommendationModel {
  final String title;
  final String rating;
  final String reviews;
  final String distance;
  final String? description;
  final String price;
  final bool isSuperstar;
  final String image; 

  const RecommendationModel({
    required this.title,
    required this.rating,
    required this.reviews,
    required this.distance,
    this.description,
    required this.price,
    required this.isSuperstar,
    required this.image,
  });
}

final List<RecommendationModel> items = [
  RecommendationModel( 
    title: 'AKS NIGHT Retro Bar',
    rating: '4.8',
    reviews: '120+',
    distance: '2.8 km',
    price: '28',
    description: "A lively bar with retro music and vibrant ambiance.",
    isSuperstar: true,
    image: 'assets/home_assets/img.png',
  ),
  RecommendationModel(
    title: 'Vegansto Salad',
    rating: '4.1',
    reviews: '53+',
    distance: '2.8 km',
    price: '15',
    description:
        "A fresh and delicious vegan salad made with organic ingredients.",
    isSuperstar: false,
    image: 'assets/home_assets/img.png',
  ),
  RecommendationModel(
    title: 'Vegan Beef Ramen',
    rating: '4.8',
    reviews: '28+',
    distance: '2.8 km',
    price: '12',
    description: "A rich and flavorful plant-based ramen bowl.",
    isSuperstar: false,
    image: 'assets/home_assets/img.png',
  ),
  RecommendationModel(
    title: 'Dalgona Chicken Soup',
    rating: '4.3',
    reviews: '43+',
    distance: '2.8 km',
    price: '28',
    description: "A unique blend of Korean flavors in a hearty chicken soup.",
    isSuperstar: false,
    image: 'assets/home_assets/img.png',
  ),
  RecommendationModel(
    title: 'Tekoyoki Seafood',
    rating: '4.1',
    reviews: '53+',
    distance: '2.8 km',
    price: '29',
    description: "A delicious mix of seafood flavors in a traditional dish.",
    isSuperstar: false,
    image: 'assets/home_assets/img.png',
  ),
];
