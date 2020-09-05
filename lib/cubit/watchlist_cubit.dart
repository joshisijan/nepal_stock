import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nepal_stock/functions/watchlist_repo.dart';
import 'package:nepal_stock/models/models.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistInitial());

  getAllSymbols() async {
    try {
      emit(WatchlistInitial());
      List<SymbolModel> symbolList =
          await WatchlistRepo.instance().getSymbols();
      emit(WatchlistLoaded(symbolList));
    } catch (error) {
      emit(WatchlistError());
    }
  }

  addSymbol(SymbolModel symbol) async {
    await WatchlistRepo.instance().insertSymbol(symbol);
    emit(WatchlistInitial());
  }

  deleteSymbol(String id) async {
    await WatchlistRepo.instance().deleteSymbol(id);
    emit(WatchlistInitial());
  }
}
