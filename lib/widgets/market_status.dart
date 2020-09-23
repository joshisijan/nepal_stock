import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_stock/api/api_url.dart';

class MarketStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: http.get(kStatus),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Text('Loading...');
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }else{
            if(snapshot.data == null){
              return Text('Error occured.');
            }else {
              if(snapshot.data.statusCode != 200){
                return Text('Error occured.');
              }else{
                return Text(snapshot.data.body);
              }
            }
          }
        },
      ),
    );
  }
}
