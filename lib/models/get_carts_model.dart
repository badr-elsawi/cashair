import 'cart_model.dart';

class GetCartsModel {
  late bool success ;
  late List<Carts> carts ;
  GetCartsModel.fromJson(Map<String,dynamic> json){
    success = json['success'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts.add(new Carts.fromJson(v));
      });
    }
  }
}

class Carts {
  late String sId;
  late String? cartId;
  late String? userId;
  //Null? gatewayNumber;
  late int actualWeight;
  late int expectedWeight;
  late int numberOfProduct;
  late int totalPrice;
  late bool closed;
  late List<Products> products;
  late int iV;
  late String createdAt;
  late String updatedAt;

  Carts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartId = json['cart_id'];
    userId = json['user_id'];
    //gatewayNumber = json['gateway_number'];
    actualWeight = json['actual_weight'];
    expectedWeight = json['expected_weight'];
    numberOfProduct = json['numberOfProduct'];
    totalPrice = json['totalPrice'];
    closed = json['closed'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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


//*********************************************************************




