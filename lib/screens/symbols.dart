import 'package:flutter/material.dart';
import '../config/palette.dart';

class Symbols extends StatefulWidget {
  @override
  _SymbolsState createState() => _SymbolsState();
}

class _SymbolsState extends State<Symbols> {
  final PageStorageKey symbolsStorageKey = PageStorageKey('symbols');

  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Palette.black,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Symbols',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 30.0,
                      padding: EdgeInsets.all(10.0),
                      color: Palette.darkGreen,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
