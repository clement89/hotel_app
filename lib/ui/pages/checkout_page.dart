import 'dart:async';

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
    if (viewModel.count == 0) {
      return Container(
        child: Center(child: Text('No items in the cart.!')),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Card(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Divider(
                color: Colors.black38,
                height: 0.2,
                indent: 15,
                endIndent: 15,
              ),
              itemCount: viewModel.cartItems.length + 1,
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
                if (index == viewModel.cartItems.length) {
                  return _buildTotal(viewModel);
                }
                return CartItem(
                  dish: viewModel.cartItems[index],
                );
              },
            ),
          ),
          _buildOrderNow(context, viewModel),
        ],
      ),
    );
  }

  _buildHeader(CartViewModel viewModel) {
    String count = viewModel.count.toString();
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

  _buildOrderNow(BuildContext context, CartViewModel viewModel) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: SizedBox(
        height: 60,
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.teal,
          child: Text(
            'Place Order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async {
            await _showMyDialog(context, viewModel);
            Navigator.of(context).pop();
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  _buildTotal(CartViewModel viewModel) {
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
              'INR ${viewModel.total.toStringAsFixed(2)}',
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

  Future<void> _showMyDialog(
      BuildContext context, CartViewModel viewModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Order successfully placed.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                viewModel.placeOrder();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
