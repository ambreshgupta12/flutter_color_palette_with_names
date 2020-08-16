import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CataLogModel {
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  // Get item by [id]
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  // Get item by its position in the catalog.
  Item getByPosition(int position) => getById(position);

}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name) :color=Colors.primaries[id % Colors.primaries.length];
  @override
  int get hashCode => id;
  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}