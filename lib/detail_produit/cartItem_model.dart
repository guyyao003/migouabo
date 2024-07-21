import 'package:flutter/material.dart';

class CartItem {
  final String nomProduit;
  final double prix;
  final String image;
  final String categorie;
  final int quantite;
  final String description;

  CartItem({
    required this.nomProduit,
    required this.prix,
    required this.image,
    required this.categorie,
    required this.quantite,
    required this.description,
  });
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    final index = _items.indexWhere((i) => i.nomProduit == item.nomProduit);
    if (index >= 0) {
      _items[index] = CartItem(
        nomProduit: item.nomProduit,
        prix: item.prix,
        image: item.image,
        categorie: item.categorie,
        quantite: _items[index].quantite + item.quantite,
        description: item.description,
      );
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.removeWhere((i) => i.nomProduit == item.nomProduit);
    notifyListeners();
  }

  void incrementQuantity(CartItem item) {
    final index = _items.indexWhere((i) => i.nomProduit == item.nomProduit);
    if (index >= 0) {
      _items[index] = CartItem(
        nomProduit: item.nomProduit,
        prix: item.prix,
        image: item.image,
        categorie: item.categorie,
        quantite: _items[index].quantite + 1,
        description: item.description,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(CartItem item) {
    final index = _items.indexWhere((i) => i.nomProduit == item.nomProduit);
    if (index >= 0 && _items[index].quantite > 1) {
      _items[index] = CartItem(
        nomProduit: item.nomProduit,
        prix: item.prix,
        image: item.image,
        categorie: item.categorie,
        quantite: _items[index].quantite - 1,
        description: item.description,
      );
      notifyListeners();
    } else if (index >= 0 && _items[index].quantite == 1) {
      removeItem(item);
    }
  }

  double get totalPrice => _items.fold(0.0, (total, current) => total + current.prix * current.quantite);
}
