import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/reuseables/custom_linear_progress.dart';
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
            children: [
              Container(
                height: MediaQuery.of(context).padding.top + 24.0,
                color: Theme.of(context).canvasColor,
              ),
              Container(
                color: Theme.of(context).canvasColor,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                ),
              ),
              Container(
                height: 15.0,
                color: Theme.of(context).canvasColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color: Theme.of(context).canvasColor,
                child: Text(
                  'Search by Security Symbol or Security Name',
                  style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                color: Theme.of(context).canvasColor,
                child: AbsorbPointer(
                  absorbing: data.length > 0 ? false : true,
                  child: RawMaterialButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchDelegateScreen(companies: data, typeInt: 0,paddingTop: MediaQuery.of(context).padding.top,),
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
                            color: Colors.black.withAlpha(200),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.black.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 20.0,
                color: Theme.of(context).canvasColor,
              ),
              data.length <= 0 ? CustomLinearProgress() : SizedBox.shrink(),
              //for offline status
              SizedBox(
                height: 40.0,
              ),
            ],
          );
        },
      ),
    );
  }

}
