import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepal_stock/api/api_url.dart';
import 'package:nepal_stock/screens/search_delegate_screen.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool progressBarShown = false;
  Timer timer;
  List<dynamic> companies;

  @override
  void initState() {
    super.initState();
    getCompanies();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (companies == null || companies.length <= 0) {
        getCompanies();
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  getCompanies() async {
    try {
      setState(() {
        progressBarShown = true;
      });
      var companiesResponse = await http.get(kCompanies);
      var jsonData = jsonDecode(companiesResponse.body);
      if (jsonData != companies) {
        setState(() {
          companies = jsonData;
          progressBarShown = false;
        });
      } else {
        setState(() {
          progressBarShown = false;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 32.0,
          ),
          Text(
            'Search',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          AbsorbPointer(
            absorbing: progressBarShown,
            child: RawMaterialButton(
              onPressed: () {
                if (companies != null && companies.length > 0) {
                  showSearch(
                    context: context,
                    delegate: SearchDelegateScreen(companies: companies),
                  );
                }else{
                  getCompanies();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                width: double.maxFinite,
                color: kColorGrey1.withAlpha(150),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: kColorGrey2,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: kColorGrey2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressBarShown ? LinearProgressIndicator() : SizedBox.shrink(),
          //for offline status
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
