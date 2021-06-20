import 'package:firebase_demo/business_logic/models/dish.dart';
import 'package:firebase_demo/business_logic/viewmodels/cart_viewmodel.dart';
import 'package:firebase_demo/ui/widgets/stepper_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final Dish dish;

  const MenuItem({
    required this.dish,
  });

  @override
  Widget build(BuildContext context) {
    final _cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Flexible(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'INR ${dish.price}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              '${dish.calories} calories',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          '${dish.description}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      StepperButton(
                        addAction: () {
                          _cartViewModel.addItem(dish);
                        },
                        removeAction: () {
                          _cartViewModel.removeItem(dish);
                        },
                      ),
                      SizedBox(height: 20),
                      dish.addonCat.isEmpty
                          ? Container()
                          : Text(
                              'Customizations available',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.redAccent,
                              ),
                            ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    'https://picsum.photos/200/300', //menu.dishList[index].image
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
