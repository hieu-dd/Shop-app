import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final CartItemEntity cartItemEntity;

  const CartItem({
    Key? key,
    required this.cartItemEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemEntity.id),
      onDismissed: (direction) {
        Provider.of<CartEntity>(context, listen: false)
            .removeItem(cartItemEntity.productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Are you sure"),
                content: Text("Do you want to remove this item from cart?"),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            });
      },
      direction: DismissDirection.endToStart,
      background: Card(
          color: Theme.of(context).primaryColor,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          )),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 15,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: FittedBox(
                child: Text(
                  cartItemEntity.price.toString(),
                ),
              ),
            ),
          ),
          title: Text(cartItemEntity.title),
          subtitle: Text(cartItemEntity.price.toString()),
          trailing: Text("x ${cartItemEntity.quantity}"),
        ),
      ),
    );
  }
}
