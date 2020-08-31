import 'package:web_scraper/web_scraper.dart';
import '../models/market_info.dart';

class NepalStockScrap{

  static final String url = 'http://nepalstock.com.np/';

  static final webScraper = WebScraper(url);

  static Future<String> completeHtml() async {
    String webPage;
    if(await webScraper.loadWebPage('')){
      webPage = webScraper.getPageContent();
    }
    return webPage;
  }

  static Future<MarketInfo> getMarketInfo() async {
    List<Map<String, dynamic>> elements,
        info;
    MarketInfo marketInfo;
    if(await webScraper.loadWebPage('')){
      elements = webScraper.getElement('#market-watch .panel-body table tbody tr td',[]);
      info = webScraper.getElement('#market-watch .panel-body .top_marketinfo',[]);
    }
    marketInfo = MarketInfo();
    if(elements.length > 0)
      marketInfo.totalTurnover =  elements[1]['title'].toString();
    if(elements.length >= 4)
      marketInfo.totalTradedShares = elements[3]['title'].toString();
    if(elements.length >= 6)
      marketInfo.totalTransactions = elements[5]['title'].toString();
    if(elements.length >= 8)
      marketInfo.totalScripsTraded = elements[7]['title'].toString();
    if(elements.length >= 10)
      marketInfo.totalMarketCapitalization = elements[9]['title'].toString();
    if(elements.length >= 12)
      marketInfo.floatedMarketCapitalization = elements[11]['title'].toString();
    marketInfo.marketStatus = info.first['title'].toString();
    return marketInfo;
  }

  static Future<List<Map<String, dynamic>>> getSymbols() async {
    List<Map<String, dynamic>> elements;
    if(await webScraper.loadWebPage('')){
      elements = webScraper.getElement('#StockSymbol_Select option', ['value']);
    }
    return elements;
  }

  static symbolDetail(String n) async {
    List<Map<String, dynamic>> elements;
    if(await webScraper.loadWebPage('/company/display/' + n)){
      elements = webScraper.getElement('#company-view table tbody tr td', []);
    }
    return elements;
  }

}