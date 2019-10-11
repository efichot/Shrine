import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
      body: Center(
        child: Text('You did it!'),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
