import 'package:flutter/material.dart';

import 'widgets/text_form_field.dart';

class Item {
  String? itemName;
  double? itemPrice;

  Item({
    this.itemName,
    this.itemPrice,
  });
}

class Dasboard extends StatefulWidget {
  const Dasboard({super.key});

  @override
  State<Dasboard> createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  List<Item> items = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _itemController;
  late final TextEditingController? _priceController;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController();
    _priceController = TextEditingController();
  }

  /// Dispose of the controllers when they are no longer
  /// needed to prevent memory leaks

  @override
  void dispose() {
    _itemController.dispose();
    _priceController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInputForm(
                      controller: _itemController,
                      hintText: "Item",
                      validateMessage: 'Please provide the item name',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextInputForm(
                            controller: _priceController,
                            hintText: "Price",
                            validateMessage: 'Please provide the price',
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              items.add(Item(
                                  itemName: _itemController.text,
                                  itemPrice:
                                      double.parse(_priceController!.text)));
                              setState(() {
                                _itemController.clear();
                                _priceController.clear();
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.subdirectory_arrow_left,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Item')),
                        DataColumn(label: Text('Price'))
                      ],
                      rows: [
                        ...items.map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text(e.itemName!),
                              ),
                              DataCell(
                                Text(
                                  e.itemPrice!.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataRow(cells: [
                          const DataCell(
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              items
                                  .fold<dynamic>(
                                      0, (prev, el) => prev + el.itemPrice)
                                  .toString(),
                            ),
                          ),
                        ])
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
