import 'package:flutter/material.dart';
import 'package:nepal_stock/screens/security_detail_screen.dart';

class SearchDelegateScreen extends SearchDelegate {
  final List<dynamic> companies;

  SearchDelegateScreen({@required this.companies});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return getResult(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '') {
      return getResult(context);
    }
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (item, index) {
        return ListTile(
          dense: true,
          isThreeLine: true,
          title: Text(companies[index]['symbol'].toString()),
          subtitle: Text(companies[index]['securityName'].toString()),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          onTap: () {
            print(companies[index]['id'].toString());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SecurityDetailScreen(
                      id: companies[index]['id'].toString(),
                      symbol: companies[index]['symbol'].toString(),
                    )));
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark();
  }

  Widget getResult(BuildContext context) {
    var result = companies.where((element) {
      return element['companyName'].toString().toLowerCase().contains(query) ||
          element['symbol'].toString().toLowerCase().contains(query) ||
          element['securityName'].toString().toLowerCase().contains(query);
    }).toList();
    if(result.length <= 0){
      return Center(
        child: Text('Nothing found. Change your search query.'),
      );
    }
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (item, index) {
        return ListTile(
          dense: true,
          isThreeLine: true,
          title: Text(result[index]['symbol'].toString()),
          subtitle: Text(result[index]['securityName'].toString()),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SecurityDetailScreen(
                      id: result[index]['id'].toString(),
                      symbol: result[index]['symbol'].toString(),
                    )));
          },
        );
      },
    );
  }
}
