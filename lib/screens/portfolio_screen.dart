import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepal_stock/models/portfolio_model.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/reuseables/add_button.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/screens/search_delegate_screen.dart';
import 'package:nepal_stock/screens/security_detail_screen.dart';
import 'package:nepal_stock/widgets/portfolio_calculation.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PortfolioScreen extends StatelessWidget {
  List<dynamic> companies;

  List<PortfolioModel> allPortfolio;

  double todayPrice;

  int units = 0;

  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    companies =
        context.select((StockModel stockModel) => stockModel.getCompanies());
    return Consumer<PortfolioModel>(
      builder: (context, portfolioModel, child){
        portfolioModel.setAllPortfolio();
        allPortfolio = portfolioModel.getAllPortfolio();
        for(int i = 0; i < allPortfolio.length; i++){
          units += allPortfolio[i].quantity;
          price += (allPortfolio[i].price * allPortfolio[i].quantity);
        }
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
                'My Portfolio',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
            ),
            Container(
              color: Theme.of(context).canvasColor,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: AddButton(
                alignment: Alignment.centerRight,
                loading: companies.length > 0 ? false : true,
                onPressed: companies.length > 0
                    ? () {
                  showSearch(
                      context: context,
                      delegate: SearchDelegateScreen(
                        companies: companies,
                        typeInt: 1,
                        paddingTop: MediaQuery.of(context).padding.top,
                      ));
                }
                    : null,
              ),
            ),
            allPortfolio.length > 0 ? PortfolioCalculation(
              units: units,
              price: price,
              todayPrice: todayPrice,
            ) : SizedBox.shrink(),
            SizedBox(
              height: 5.0,
            ),
            allPortfolio.length > 0
                ? Column(
              children: allPortfolio.map((element) {
                return Container(
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    dense: true,
                    isThreeLine: true,
                    title: Text(
                      element.symbol,
                      style: TextStyle(
                        color:
                        Theme.of(context).textTheme.caption.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      element.name + '\n' + DateFormat("d MMMM, y")
                          .format(DateTime.fromMillisecondsSinceEpoch(element.date)),
                      style: TextStyle(
                        color:
                        Theme.of(context).textTheme.caption.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: PopupMenuButton(
                      color: Theme.of(context).brightness ==
                          Brightness.light
                          ? Theme.of(context).canvasColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (_) => SecurityDetailScreen(
                              id: element.id,
                              symbol: element.symbol,
                            ),
                          ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ConfirmAlert(
                                  title: 'Remove from Portfolio',
                                  content:
                                  'Do you really want to remove  ${element.symbol} (${element.name}) from portfolio?',
                                  onYes: () {
                                    PortfolioModel().deletePortfolio(
                                        element.portfolioId);
                                    Navigator.of(context).pop();
                                  },
                                );
                              });
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.short_text,
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .color,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('View Security Detail'),
                              ],
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .color,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Remove from Portfolio'),
                              ],
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                );
              }).toList(),
            )
                : Container(
                height: MediaQuery.of(context).size.height * 0.33,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.view_stream,
                      size: 36.0,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Nothing found on your Portfolio.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .caption
                            .color,
                      ),
                    ),
                  ],
                )),
            //for offline status
            SizedBox(
              height: 40.0,
            ),
          ],
        );
      },
    );
  }
}
