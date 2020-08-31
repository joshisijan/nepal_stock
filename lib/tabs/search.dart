import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';


class SearchTab extends StatelessWidget {

  final PageStorageKey searchStorageKey = PageStorageKey('search');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: searchStorageKey,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 20.0,
            ),
            child: Text(
              'Search',
              style: Theme.of(context).textTheme.headline2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: InkWell(
              splashColor: Palette.darkGreen,
              child: Container(
                child: Text(
                  'Search By Symbol',
                  style: TextStyle(
                    color: Palette.lightBlack.withAlpha(180),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Palette.white,
                ),
              ),
              onTap: (){
                showSearch(
                  context: context,
                  delegate: Search(),
                );
              },
            ),
          ),
          DoubledList(
            children: [
              DoubledListItem(
                title: 'Browse all Symbol',
                icon: Icons.near_me,
                iconBackgroundColor: Colors.purple,
                iconColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                        return Symbols();
                      }
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
