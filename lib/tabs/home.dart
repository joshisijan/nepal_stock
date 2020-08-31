import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../widgets/widgets.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  final PageStorageKey homeStorageKey = PageStorageKey('home');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: homeStorageKey,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Palette.black,
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: (){

                },
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: TopDetailPanel(),
          ),
        ],
      ),
    );
  }
}
