import 'package:cashair/models/product_model.dart';

class HomeModel {
  late bool success;
  late List<Products> products;

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

}

class Products {
  late String sId;
  late String barcode;
  late String name;
  late int price;
  late int weight;
  late int quantity;
  late String image;

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    barcode = json['barcode'];
    name = json['name'];
    price = json['price'];
    weight = json['weight'];
    quantity = json['quantity'];
    image = json['image'];
  }
}

