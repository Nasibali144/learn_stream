import 'dart:async';
import 'package:learn_stream/stream%20three/model.dart';

class CartController {
  Cart _cart = Cart(id: 1, items: []);
  final StreamController<Cart> _controller = StreamController.broadcast();

  void addToCard({required Product product, required int quantity}) {
    final isExist = _cart.items.any((element) => element.id == product.id);
    if(isExist) {
      ///TODO: Warning
      final item = _cart.items.firstWhere((element) => element.id == product.id);
      if(quantity == 1) {
        item.quantity++;
      } else if(quantity == -1 && item.quantity > 0){
        item.quantity--;
      }

      item.total = item.quantity * item.product.price;
      if(item.quantity == 0) {
        _cart.items.remove(item);
      }

    } else if(quantity == 1) {
      final cartItem = CartItem(id: product.id, product: product);
      _cart.items.add(cartItem);
    }

    _cart = _cart.copyWith(items: _cart.items);
    _controller.sink.add(_cart);
  }

  Stream<Cart> get stream => _controller.stream;
  Cart get cart => _cart;
}
