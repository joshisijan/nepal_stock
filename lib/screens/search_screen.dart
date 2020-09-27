import 'package:flutter/material.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/screens/search_delegate_screen.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:provider/provider.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Selector<StockModel, List<dynamic>>(
        selector: (context, stockModel) => stockModel.getCompanies(),
        builder: (_, data, __){
          return ListView(
            padding: EdgeInsets.all(10.0),
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
              Text(
                'Search by Security Symbol or Security Name',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 15.0,
              ),
              AbsorbPointer(
                absorbing: data.length > 0 ? false : true,
                child: RawMaterialButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchDelegateScreen(companies: data, typeInt: 0,),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: kColorBlack1,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(color: kColorBlack1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              data.length <= 0 ? Container(height: 1.0,child: LinearProgressIndicator()) : SizedBox.shrink(),
              //for offline status
              SizedBox(
                height: 20.0,
              ),
            ],
          );
        },
      ),
    );
  }

}
