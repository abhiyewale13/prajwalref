class CartItem {
  final String name;
  final String image;
  final String description;
  final double price;
  final int quantity; 

  CartItem({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({String? name, String? image, String? description, double? price, int? quantity}) {
    return CartItem(
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
