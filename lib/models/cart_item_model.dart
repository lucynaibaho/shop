import 'product_model.dart';

class CartItemModel {
  CartItemModel({required this.product, required this.quantity});

  final ProductModel product;
  int quantity;

  int get subtotal => product.price * quantity;
}
