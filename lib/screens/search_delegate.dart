import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../config/theme.dart';
import '../functions/ns.dart';


class Search extends SearchDelegate{

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query = '';
        },
      ),
      SizedBox(
        width: 10.0,
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: NepalStockScrap.getSymbols(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 8.0,
              ),
            );
          }else{
            if(snapshot.hasError){
              return Center(
                child: Text('An error occured' + snapshot.error.toString(),style: TextStyle(color: Palette.white),),
              );
            }else{
              var data = snapshot.data;
              return Container();
            }
          }
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return kAppTheme;
  }

}