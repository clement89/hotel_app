import 'package:firebase_demo/business_logic/models/dish.dart';
import 'package:firebase_demo/business_logic/viewmodels/cart_viewmodel.dart';
import 'package:firebase_demo/ui/widgets/stepper_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Dish dish;

  const CartItem({
    required this.dish,
  });

  @override
  Widget build(BuildContext context) {
    final _cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.crop_square_sharp,
                  color: dish.isVeg ? Colors.green : Colors.redAccent,
                  size: 28,
                ),
                Icon(Icons.circle,
                    color: dish.isVeg ? Colors.green : Colors.redAccent,
                    size: 12),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${dish.name}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'INR ${dish.price}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${dish.calories} calories',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            StepperButton(
              addAction: () {
                _cartViewModel.addItem(dish);
              },
              removeAction: () {
                _cartViewModel.removeItem(dish);
              },
              count: dish.count,
            ),
          ],
        ),
      ),
    );
  }
}
