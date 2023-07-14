class CartItem {
  String name, img, id, price;

  CartItem({
    required this.name,
    required this.img,
    required this.id,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
      };
}