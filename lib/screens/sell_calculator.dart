import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../widgets/widgets.dart';

class SellCalculator extends StatefulWidget {

  @override
  _SellCalculatorState createState() => _SellCalculatorState();
}

class _SellCalculatorState extends State<SellCalculator> {

  TextEditingController _numberController;
  TextEditingController _priceController;
  TextEditingController _sellingPriceController;

  final _formKey = GlobalKey<FormState>();

  FocusNode _numberNode,
      _priceNode,
      _sellingPriceNode;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _priceController = TextEditingController();
    _sellingPriceController = TextEditingController();
    _numberNode = FocusNode();
    _priceNode = FocusNode();
    _sellingPriceNode = FocusNode();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {

    _numberController.dispose();
    _priceController.dispose();
    _sellingPriceController.dispose();
    _numberNode.dispose();
    _priceNode.dispose();
    _sellingPriceNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  double shareAmount = 0.0,
      brokerCommission = 0.0,
      sebonCommission = 0.0,
      capitalGain = 0.0,
      capitalGainTax = 0.0,
      dpFee = 0.0,
      totalAmount = 0.0,
      net = 0.0;
  String accountType = 'individual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.black,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sell Calculator',
                    style: Theme.of(context).textTheme.headline2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'profit/loss',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.lightGreen.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    focusNode: _numberNode,
                    outerTitle: 'Number of Shares',
                    hint: 'Number of Shares',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _numberController,
                    onlyNumber: true,
                    onEditingComplete: (){
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(_priceNode);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Field is required';
                      }else if(double.parse(value) <= 0.0){
                        return 'Must be greater than 0';
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        shareAmount = brokerCommission = sebonCommission = net = capitalGain = capitalGainTax = totalAmount = dpFee = 0.0;
                      });
                    },
                  ),
                  CustomTextField(
                    focusNode: _priceNode,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    outerTitle: 'Buying Price of Shares',
                    hint: 'Buying Price of Shares',
                    helperText: 'In Nepali Rupees',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    controller: _priceController,
                    onEditingComplete: (){
                      FocusScope.of(context).requestFocus(_sellingPriceNode);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Field is required';
                      }else if(double.parse(value) <= 0.0){
                        return 'Must be greater than 0';
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        shareAmount = brokerCommission = sebonCommission = net = capitalGain = capitalGainTax = dpFee = totalAmount = 0.0;
                      });
                    },
                  ),
                  CustomTextField(
                    focusNode: _sellingPriceNode,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(top: 10.0),
                    outerTitle: 'Selling price of Shares',
                    hint: 'Selling Price of Shares',
                    helperText: 'In Nepali Rupees',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    controller: _sellingPriceController,
                    onEditingComplete: (){
                      FocusScope.of(context).unfocus();
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Field is required';
                      }else if(double.parse(value) <= 0.0){
                        return 'Must be greater than 0';
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        shareAmount = brokerCommission = sebonCommission = totalAmount = net = capitalGain = capitalGainTax = dpFee = 0.0;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              groupValue: accountType,
                              value: 'individual',
                              activeColor: Palette.darkGreen.withAlpha(200),
                              onChanged: (value){
                                setState(() {
                                  accountType = value;
                                  shareAmount = brokerCommission = sebonCommission = totalAmount = net = capitalGain = capitalGainTax = dpFee = 0.0;
                                });
                              },
                            ),
                            Text('Individual')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              groupValue: accountType,
                              value: 'institution',
                              activeColor: Palette.darkGreen.withAlpha(200),
                              onChanged: (value){
                                setState(() {
                                  accountType = value;
                                  shareAmount = brokerCommission = sebonCommission = totalAmount = net = capitalGain = capitalGainTax = dpFee = 0.0;
                                });
                              },
                            ),
                            Text('Institution'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    title: 'Calculate',
                    onPressed: (){
                      calculate(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  TitleDetail(
                    title: 'Share Amount',
                    detail: 'Rs. ' + shareAmount.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'Broker Commission',
                    detail: '- Rs. ' + brokerCommission.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'SEBON Commission',
                    detail: '- Rs. ' + sebonCommission.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'DP Fee',
                    detail: '- Rs. ' + dpFee.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'Capital Gain',
                    detail: capitalGain > 0.0 ? 'Rs. ' + capitalGain.toString() : 'No Gain',
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'Capital Gain Tax(5%)',
                    detail: capitalGain > 0.0 ? '- Rs. ' + capitalGainTax.toString() : 'No Gain',
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  Divider(
                    color: Palette.darkGreen,
                  ),
                  TitleDetail(
                    title: 'Total Receivable Amount',
                    detail: 'Rs. ' + totalAmount.toString(),
                    titleStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      wordSpacing: 0,
                      color: Palette.darkGreen,
                    ),
                    detailStyle: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Palette.darkGreen,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: net == 0.0 ? 'Nor Profit Nor Loss' : net > 0.0 ? 'Profit' : 'Loss',
                    detail: net != 0 ? 'Rs. ' + net.toString() : '',
                    titleStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      wordSpacing: 0,
                      color: net == 0.0 ? Palette.lightGreen.withAlpha(200) : net > 0.0 ? Palette.lightGreen.withAlpha(200) : Theme.of(context).errorColor.withAlpha(200),
                    ),
                    detailStyle: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: net == 0.0 ? Palette.lightGreen.withAlpha(200) : net > 0.0 ? Palette.lightGreen.withAlpha(200) : Theme.of(context).errorColor.withAlpha(200),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double roundDouble(double x){
    return double.parse(x.toStringAsFixed(2));
  }

  double calculateBrokerCommission(double x){
    double commission = 25.0;
    if(x <= 50000.0){
      commission = (0.6 * x) / 100;
    }else if(x > 50000.0 && x <= 500000.0){
      commission = (0.55 * x) / 100;
    }else if(x > 500000.0 && x <= 2000000.0){
      commission = (0.5 * x) / 100;
    }else if(x > 2000000.0 && x <= 10000000){
      commission = (0.45 * x) / 100;
    }else{
      commission = (0.4 * x) / 100;
    }

    if(commission < 25.0)
      return 25.0;
    else
      return commission;
  }

  calculate(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
    if(_formKey.currentState.validate()){

      double number = double.parse(_numberController.text);
      double price = double.parse(_priceController.text);
      double sellingPrice = double.parse(_sellingPriceController.text);

      double cP = price * number;

      shareAmount = brokerCommission = sebonCommission = totalAmount = net = capitalGain = capitalGainTax = dpFee = 0.0;

      dpFee = 25.0;

      shareAmount = number * sellingPrice;
      brokerCommission = calculateBrokerCommission(shareAmount);
      sebonCommission = shareAmount * (0.015 / 100);

      capitalGain = shareAmount - cP - brokerCommission - sebonCommission - dpFee - calculateBrokerCommission(cP) - cP * (0.015 / 100) - dpFee;

      if(capitalGain > 0.0){
        if(accountType == 'individual')
          capitalGainTax = capitalGain * 0.05;
        else
          capitalGainTax = capitalGain * 0.1;
      }

      totalAmount = shareAmount - brokerCommission - dpFee - sebonCommission - capitalGainTax;

      net = capitalGain - capitalGainTax;

      setState(() {
        shareAmount = roundDouble(shareAmount);
        brokerCommission = roundDouble(brokerCommission);
        sebonCommission = roundDouble(sebonCommission);
        totalAmount = roundDouble(totalAmount);
        net = roundDouble(net);
        capitalGainTax = roundDouble(capitalGainTax);
        capitalGain = roundDouble(capitalGain);
      });
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }else{
      _scrollController.animateTo(_scrollController.position.minScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }

  }
}
