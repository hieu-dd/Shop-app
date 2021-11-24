import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartEntity>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label: Text(
                  cart.grandTotal.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Provider.of<OrderEntities>(context, listen: false).addOrder(
                    cart.items.values.toList(),
                    cart.grandTotal,
                  );
                  cart.clear();
                },
                child: const Text(
                  "Order now",
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                final cartItemEntity = cart.items.values.toList()[i];
                return CartItem(
                  cartItemEntity: cartItemEntity,
                );
              },
              itemCount: cart.items.length,
            ),
          )
        ]),
      ),
    );
  }
}
