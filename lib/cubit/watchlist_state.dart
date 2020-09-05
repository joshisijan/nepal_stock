part of 'watchlist_cubit.dart';

abstract class WatchlistState extends Equatable {
  final List<SymbolModel> symbols;
  const WatchlistState(this.symbols);

  @override
  List<Object> get props => [symbols];
}

class WatchlistInitial extends WatchlistState {
  static final List<SymbolModel> symbolList = [];
  WatchlistInitial() : super(symbolList);

  @override
  List<Object> get props => [symbolList];
}

class WatchlistLoaded extends WatchlistState {
  final List<SymbolModel> symbolList;
  WatchlistLoaded(this.symbolList) : super(symbolList);

  @override
  List<Object> get props => [symbolList];
}

class WatchlistError extends WatchlistState {
  WatchlistError() : super([]);
}
