import 'package:firebase_demo/business_logic/viewmodels/cart_viewmodel.dart';
import 'package:firebase_demo/ui/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Order Summery',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: Consumer<CartViewModel>(builder: (context, viewModel, child) {
        return _buildBody(context, viewModel);
      }),
    );
  }

  _buildBody(BuildContext context, CartViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          separatorBuilder: (context, index) => Divider(
            color: Colors.black38,
            height: 0.2,
            indent: 15,
            endIndent: 15,
          ),
          itemCount: viewModel.cartItems.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  _buildHeader(viewModel),
                  CartItem(
                    dish: viewModel.cartItems[index],
                  ),
                ],
              );
            }
            if (index == viewModel.cartItems.length - 1) {
              return Column(
                children: [
                  CartItem(
                    dish: viewModel.cartItems[index],
                  ),
                  _buildTotal(viewModel),
                ],
              );
            }
            return CartItem(
              dish: viewModel.cartItems[index],
            );
          },
        ),
      ),
    );
  }

  _buildHeader(CartViewModel viewModel) {
    String count = viewModel.cartItems.length.toString();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.teal,
        ),
        child: Center(
            child: Text(
          '$count Dishes - $count Items',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }

  _buildTotal(CartViewModel viewModel) {
    double total = 0.0;

    viewModel.cartItems.forEach((dish) {
      total += dish.price;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: Container(
        width: double.infinity,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total amount',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'INR ${total.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
