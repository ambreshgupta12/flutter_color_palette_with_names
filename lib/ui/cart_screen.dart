import 'package:flutter/material.dart';
import 'package:flutter_cart_item_add/notifiers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Expanded(
              child: _CartList(),
            ),
            Divider(height: 4, color: Colors.black,thickness: 4,),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    var list = context.watch<CartProvider>();
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.items.length,
        itemBuilder: (BuildContext context, int index) =>  Container(
          padding: EdgeInsets.all(6),
          child: Row(
            children: <Widget>[

              Text(
                '⚫ ${list.items[index].name}',
                style: itemNameStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('\$${context.watch<CartProvider>().totalPrice}',
              style: hugeStyle),
          SizedBox(width: 24),
          FlatButton(
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Buying not supported yet.'),
                ));
              },
              child: Text('BUY'))
        ],
      ),
    );
  }
}
