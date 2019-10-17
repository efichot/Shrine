import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category category;

  @override
  void initState() {
    super.initState();
    category = Category.all;
  }

  List<Card> _buildCards(BuildContext context) {
    final List<Product> listProducts =
        ProductsRepository.loadProducts(category);
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return listProducts.map((Product product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 4 / 2.7,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: theme.textTheme.button,
                        maxLines: 1,
                      ),
                      SizedBox(height: 8),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Text('SHRINE'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            print('search');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'tune',
          ),
          onPressed: () {
            print('tune');
          },
        )
      ],
    );

    Drawer drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 55,
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 10),
              child: Text('MENU', style: Theme.of(context).textTheme.button),
            ),
            color: kShrinePink100,
          ),
          ListTile(
            title: Text('All'),
            onTap: () {
              setState(() {
                category = Category.all;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Accessories'),
            onTap: () {
              setState(() {
                category = Category.accessories;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Clothing'),
            onTap: () {
              setState(() {
                category = Category.clothing;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              setState(() {
                category = Category.home;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: _buildCards(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
