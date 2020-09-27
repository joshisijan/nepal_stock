import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepal_stock/api/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_stock/models/time_value_model.dart';

class StockModel extends ChangeNotifier {
  //all companies
  List<dynamic> _companies = [];
  //all index values
  List<dynamic> _indexValue = [];
  //nepse index from index value
  Map<String, dynamic> _nepseIndexValue;
  //market status
  Map<String, dynamic> _marketStatus;
  //index chart
  List<TimeValueModel> _indexChart = [];
  //market summary
  List<dynamic> _marketSummary = [];

  // timers
  Timer _marketStatusTimer;

  //privates
  bool _marketOpen = false;
  int _id = 58;

  //set id
  setId(int id){
    _id = id;
  }

  //set everything
  setEverything() {
    setCompanies();
    setMarketStatus();
    setIndexValue();
    setIndexChart(_id);
    setMarketSummary();
  }

  // getter for companies
  getCompanies() => _companies;
  //setter for companies
  setCompanies() async {
    try {
      var companiesResponse = await http.get(kCompanies);
      if (companiesResponse?.statusCode == 200) {
        var jsonData = jsonDecode(companiesResponse.body);
        _companies = jsonData;
        notifyListeners();
      }
    } catch (e) {
      print('error from get companies:\n' + e.toString());
    }
  }


  //get market status
  getMarketStatus() => _marketStatus;

  //set market status
  setMarketStatus() {
    setMarketStatusInner();
    _marketStatusTimer = Timer.periodic(Duration(seconds: 8), (timer) {
      setMarketStatusInner();
    });
  }

  //set market status inner
  setMarketStatusInner() async {
    try {
      var statusResponse = await http.get(kStatus);
      if (statusResponse?.statusCode == 200) {
        var jsonData = jsonDecode(statusResponse.body);
        _marketStatus = jsonData;
        if (_marketStatus['isOpen'] != 'CLOSE') {
          _marketOpen = true;
        }
        // timer for running when market open
        if(_companies.length <= 0) setCompanies();
        if(_indexChart.length <= 0) setIndexChart(_id);
        if(_indexValue.length <= 0) setIndexValue();
        if(_marketSummary.length <= 0) setMarketSummary();
        if(_marketOpen == true){
          setIndexValue();
          setIndexChart(_id);
          setMarketSummary();
        }
        // timer for running when market open
        notifyListeners();
      }
    } catch (e) {
      print('error from get market stats:\n' + e.toString());
    }
  }

  //get index value
  getIndexValue() => _indexValue;
  //get nepse index value
  getNepseIndexValue() => _nepseIndexValue;

  //set index value
  setIndexValue() async {
    try {
      var indexValueResponse = await http.get(kIndex);
      if (indexValueResponse?.statusCode == 200) {
        var jsonData = jsonDecode(indexValueResponse.body);
        _indexValue = jsonData;
        _nepseIndexValue = _indexValue
            .firstWhere((element) => element['id'].toString() == '58');
        notifyListeners();
      }
    } catch (e) {
      print('error from get index value:\n' + e.toString());
    }
  }

  //get index chart
  getIndexChart() => _indexChart;

  //set index chart
  setIndexChart(id) async {
    try {
      var timeValue = await http.get('$kTimeValue/${id.toString()}');
      if(timeValue.statusCode == 200){
        _indexChart = [];
        var jsonData = jsonDecode(timeValue.body);
        for (int i = 0; i < jsonData.length; i++) {
          _indexChart.add(TimeValueModel(
              DateTime.fromMillisecondsSinceEpoch(jsonData[i][0] * 1000),
              double.parse(jsonData[i][1].toString())));
        }
        notifyListeners();
      }
    } catch (e) {
      print('error from index chart\n' + e.toString());
    }
  }

  //get market summary
  getMarketSummary() => _marketSummary;

  //set market summary
  setMarketSummary() async {
    try {
      var marketSummary = await http.get(kMarketSummary);
      if(marketSummary.statusCode == 200){
        var jsonData = jsonDecode(marketSummary.body);
        _marketSummary = jsonData;
        notifyListeners();
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _marketStatusTimer?.cancel();
    super.dispose();
  }
}
