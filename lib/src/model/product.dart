class Product {
  int id;
  String name;
  String category;
  String image;
  double price;
  double partprice;
  double familyprice;
  bool isliked;
  bool isSelected;
  String description;
  Product(
      {this.id,
      this.name,
      this.category,
      this.price,
      this.partprice,
      this.familyprice,
      this.isliked,
      this.isSelected = false,
      this.description,
      this.image});
}
