import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperButton extends StatefulWidget {
  final Function addAction;
  final Function removeAction;
  StepperButton({
    required this.addAction,
    required this.removeAction,
  });

  @override
  _StepperButtonState createState() => _StepperButtonState();
}

class _StepperButtonState extends State<StepperButton> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (count > 0) {
                  setState(() {
                    --count;
                  });
                  widget.removeAction();
                }
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              child: Text(
                count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    ++count;
                  });
                  widget.addAction();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                )),
          ],
        ),
      ),
    );
  }
}
