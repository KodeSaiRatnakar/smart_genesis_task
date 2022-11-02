class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});



 static List<Product> convertListToProductList(List<dynamic> list){
    List<Product> items = [];

    items = list.map((singleItem){
      return Product(id: singleItem["id"].toString(), title: singleItem["title"], price: singleItem["price"].toString(), description: singleItem['description'], category: singleItem['category'], image: singleItem['image'], rating: singleItem['rating']);

    }).cast<Product>().toList();





    return items;

  }
}
