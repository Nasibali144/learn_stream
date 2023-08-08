import 'dart:async';

import 'package:learn_stream/stream%20three/model.dart';

class CartController {
  Cart _cart = Cart(id: 1, items: []);
  final StreamController<Cart> _controller = StreamController();

  /// uncompleted
  void addToCard({required Product product, required int quantity}) {
    final isExist = _cart.items.any((element) => element.id == product.id);
    if(isExist) {
      final item = _cart.items.firstWhere((element) => element.id == product.id);
    } else {

    }

    if(quantity == 1) {

    }

    if(quantity == -1) {

    }

    final cartItem = CartItem(id: product.id, product: product);
    if (quantity >= 1) {
      _cart.items.removeWhere((element) => element.id == cartItem.id);
      _cart.items.add(cartItem);
    } else {
      _cart.items.removeWhere((element) => element.id == cartItem.id);
    }
    _cart = _cart.copyWith(items: _cart.items);
    _controller.sink.add(_cart);
  }

  Stream<Cart> get stream => _controller.stream;
  Cart get cart => _cart;
}
