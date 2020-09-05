import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SymbolModel extends Equatable {
  final int id;
  final String symbol;
  final String value;

  const SymbolModel({this.id, @required this.symbol, @required this.value});

  @override
  List<Object> get props => [symbol, value];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'value': value,
    };
  }
}
