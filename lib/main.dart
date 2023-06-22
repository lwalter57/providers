import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providers/screens/item_detail.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: const MyApp(),
    ),
  );
}

class Item {
  Item({required this.price, required this.name, this.description});
  String name;
  int price;
  String? description;
  bool isOrdered = false;
}

class ItemProvider extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  //int getTotal() {
  //                  'Total : ${itemProvider.items.where((element) => element.isOrdered == true).map((e) => e.price).toList().fold(0, (a, b) => a + b).toString()} €',

  //return _items.reduce((value, element) => value+element.price);
  //}

  void orderItem(Item item) {
    item.isOrdered = true;
    notifyListeners();
  }

  Item getElementByID(int itemID) {
    return _items[itemID];
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boutique',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Column(children: [
          Consumer<ItemProvider>(
            builder: (context, itemProvider, child) {
              return Card(
                child: Text(itemProvider.getTotal().toString()),
              );
            },
          ),
          Expanded(
            child: Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                return ListView.builder(
                  itemCount: itemProvider.items.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(itemProvider.items[index].name),
                      subtitle: Text(
                          '${itemProvider.items[index].price.toString()} €'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ItemDetail(itemID: index)));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final Item item = Item(
                    price: 20,
                    name: 'D4',
                    description:
                        "Ouaa trop cool diablo 4 y'a des barbares qui tournent 20/20");
                Provider.of<ItemProvider>(context, listen: false).add(item);
              },
              child: const Icon(Icons.add))
        ]),
      ),
    );
  }
}
