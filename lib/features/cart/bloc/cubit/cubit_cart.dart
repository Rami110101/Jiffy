import 'package:competition/features/cart/bloc/states/state_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(totalPrice: 0, totalWeight: 0));

  void updateTotals(List<Product> products) {
    final double totalPrice = products.fold(0, (sum, item) => sum + item.price);
    final double totalWeight =
        products.fold(0, (sum, item) => sum + item.weight);
    emit(CartState(totalPrice: totalPrice, totalWeight: totalWeight));
  }
}
