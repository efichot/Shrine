import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  List<Card> _buildCards(BuildContext context) {
    List<Product> listProducts = ProductsRepository.loadProducts(Category.all);

    if (listProducts == null || listProducts.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return listProducts.map((Product product) {
      return Card(
        clipBehavior: Clip.antiAlias,
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
                  padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('menu toggle');
          },
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
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: _buildCards(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
