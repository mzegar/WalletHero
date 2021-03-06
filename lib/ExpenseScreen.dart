import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:wallet_hero/Utils.dart';

class ExpenseScreen extends StatefulWidget {
  final Function onAdd;
  const ExpenseScreen({Key? key, required this.onAdd}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  var controller = MoneyMaskedTextController(
    leftSymbol: '\$',
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  var textViewController = TextEditingController();

  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Utils.createCard(
                const Text(
                  "New Expense",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Utils.createCard(
                const Text(
                  "What was the total expense cost?",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Utils.createCard(
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onChanged: (String amount) {
                    setState(() {
                      isDisabled = amount.contains("\$0.00");
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Utils.createCard(
                const Text(
                  "If you'd like, consider adding a note to explain the purchase",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Utils.createCard(
                TextField(
                  controller: textViewController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter an expense name',
                  ),
                ),
              ),
              Utils.createCard(
                ElevatedButton.icon(
                  onPressed: isDisabled
                      ? null
                      : () {
                          // Close any open keyboard.
                          FocusManager.instance.primaryFocus?.unfocus();
                          widget.onAdd(
                              controller.text, textViewController.text);
                          controller.text = "\$0.00";
                          textViewController.text = "";
                          isDisabled = true;
                        },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                  label: const Text(
                    "Add expense",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 75),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
