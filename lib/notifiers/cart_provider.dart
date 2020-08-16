import 'package:flutter/material.dart';
import 'package:flutter_cart_item_add/model/catalog_model.dart';

class CartProvider extends ChangeNotifier{

  CataLogModel _catalog;

  CataLogModel get catalog => _catalog;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];


  set catalog(CataLogModel newCatalog ) {
    assert(newCatalog!=null);
    assert(_itemIds.every((id) => _catalog.getById(id)!=null));
    _catalog = newCatalog;
    notifyListeners();
  }

  List<Item> get items=>_itemIds.map((id) => _catalog.getById(id)).toList();


  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item){
    _itemIds.add(item.id);
    notifyListeners();
  }

  /// The current total price of all items.
  int get totalPrice=>items.fold(0, (total, current) => total+current.price);

}