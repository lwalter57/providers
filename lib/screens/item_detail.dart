import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providers/main.dart';

class ItemDetail extends StatelessWidget {
  final int itemID;
  const ItemDetail({super.key, required this.itemID});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlizzardShop',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: UnconstrainedBox(
        child: Consumer<ItemProvider>(builder: (context, itemProvider, child) {
          return Card(
            child: Column(
              children: [
                Text(itemProvider.getElementByID(itemID).name),
                Text(
                    '${itemProvider.getElementByID(itemID).price.toString()} €'),
                Text(itemProvider.getElementByID(itemID).description!),
                IconButton(
                    onPressed: () => itemProvider
                        .orderItem(itemProvider.getElementByID(itemID)),
                    icon: const Icon(Icons.add))
              ],
            ),
          );
        }),
      ),
    );
  }
}
