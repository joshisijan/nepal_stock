import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/palette.dart';
import 'package:nepal_stock/cubit/watchlist_cubit.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class WatchlistTab extends StatelessWidget {
  final PageStorageKey watchlistStorageKey = PageStorageKey('watchlist');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: watchlistStorageKey,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 50.0,
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Text(
              'Watchlist',
              style: Theme.of(context).textTheme.headline2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          CustomButton(
            title: 'Add New to Watchlist',
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            onPressed: () {
              context.bloc<WatchlistCubit>().addSymbol(SymbolModel(
                    symbol: 'NICA',
                    value: '2000',
                  ));
            },
          ),
          BlocBuilder<WatchlistCubit, WatchlistState>(
            builder: (context, state) {
              if (state is WatchlistInitial) {
                context.bloc<WatchlistCubit>().getAllSymbols();
                return Column(
                  children: state.symbols.map<Widget>((symbol) {
                    return ListTile(
                      title: Text(symbol.symbol.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          context
                              .bloc<WatchlistCubit>()
                              .deleteSymbol(symbol.id.toString());
                        },
                      ),
                    );
                  }).toList(),
                );
              } else if (state is WatchlistError) {
                return Text(
                  'An error occured.',
                  style: TextStyle(color: Palette.darkGreen),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      title: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'SYM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'LTP',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CH P',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CH %',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(),
                        ],
                      ),
                      trailing: SizedBox(),
                    ),
                    Column(
                      children: state.symbols.map<Widget>((symbol) {
                        return TabldeSymbolWidget(
                          id: symbol.id.toString(),
                          symbol: symbol.symbol,
                          onPressed: () {
                            context
                                .bloc<WatchlistCubit>()
                                .deleteSymbol(symbol.id.toString());
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
