import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart_item_add/model/catalog_model.dart';
import 'package:flutter_cart_item_add/notifiers/cart_provider.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _MyAppBar(),
          SliverToBoxAdapter(

            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate(
                        (context, index) => _MyListItem(
                      index: index,
                    ),),
          )
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalAddCount= context.select<CartProvider,int>((cartProvider) => cartProvider.items.length);

    return SliverAppBar(
      centerTitle: true,
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      actions: <Widget>[

        InkWell(
          onTap: () => Navigator.pushNamed(context, '/cart'),
          child: totalAddCount!=0?Badge(
            position: BadgePosition.topRight(top: 2, right: -8),
            badgeContent: Text(totalAddCount.toString()),
            child: Icon(Icons.shopping_cart),
          ):Icon(Icons.shopping_cart),
        ),

        SizedBox(width: 16,)
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var item= context.select<CataLogModel,Item>((cataLogModel)=>cataLogModel.getById(index));
   var textTheme = Theme.of(context).textTheme.headline6;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading:  AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: item.color,
          ),
        ),
        title: Text(item.name, style: textTheme),
        trailing: _AddButton(item:item),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
 final Item item;
 _AddButton({this.item});

  @override
  Widget build(BuildContext context) {
    bool isItemInseted=context.select<CartProvider,bool>((cartProvider) => cartProvider.items.contains(item));
    return FlatButton(
        splashColor: Theme.of(context).primaryColor,
        onPressed: isItemInseted?null:(){
          print("isItemInseted:${isItemInseted}");
          var cart= context.read<CartProvider>();
          cart.add(item);

        },  child: isItemInseted ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),);
  }
}
