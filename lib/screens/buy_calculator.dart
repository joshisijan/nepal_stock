import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../widgets/widgets.dart';

class BuyCalculator extends StatefulWidget {

  @override
  _BuyCalculatorState createState() => _BuyCalculatorState();
}

class _BuyCalculatorState extends State<BuyCalculator> {

  TextEditingController _numberController;
  TextEditingController _priceController;

  final _formKey = GlobalKey<FormState>();

  FocusNode _numberNode;
  FocusNode _priceNode;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _priceController = TextEditingController();
    _numberNode = FocusNode();
    _priceNode = FocusNode();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _priceController.dispose();
    _numberNode.dispose();
    _priceNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  double shareAmount = 0.0,
      brokerCommission = 0.0,
      sebonCommission = 0.0,
      dpFee = 0.0,
      totalAmount = 0.0,
      costPerShare  = 0.0;

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
              child: Text(
                'Buy Calculator',
                style: Theme.of(context).textTheme.headline2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
                        shareAmount = brokerCommission = dpFee = sebonCommission = totalAmount = costPerShare = 0.0;
                      });
                    },
                  ),
                  CustomTextField(
                    focusNode: _priceNode,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    outerTitle: 'Price of Shares',
                    hint: 'Price of Shares',
                    helperText: 'In Nepali Rupees',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    controller: _priceController,
                    onEditingComplete: (){
                      calculate(context);
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
                        shareAmount = brokerCommission = dpFee = sebonCommission = totalAmount = costPerShare = 0.0;
                      });
                    },
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
                    detail: 'Rs. ' + brokerCommission.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'SEBON Commission',
                    detail: 'Rs. ' + sebonCommission.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  TitleDetail(
                    title: 'DP Fee',
                    detail: 'Rs. ' + dpFee.toString(),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  Divider(
                    color: Palette.darkGreen,
                  ),
                  TitleDetail(
                    title: 'Total Payable Amount',
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
                    title: 'Cost Price Per Share',
                    detail: 'Rs. ' + costPerShare.toString(),
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

      shareAmount = brokerCommission = sebonCommission = dpFee = totalAmount = costPerShare = 0.0;

      dpFee = 25.0;

      shareAmount = number * price;
      brokerCommission = calculateBrokerCommission(shareAmount);
      sebonCommission = sebonCommission + shareAmount * (0.015 / 100);

      totalAmount = shareAmount + brokerCommission + sebonCommission + dpFee;

      costPerShare = totalAmount / number;

      setState(() {
        shareAmount = roundDouble(shareAmount);
        brokerCommission = roundDouble(brokerCommission);
        sebonCommission = roundDouble(sebonCommission);
        totalAmount = roundDouble(totalAmount);
        costPerShare = roundDouble(costPerShare);
      });
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }else{
      _scrollController.animateTo(_scrollController.position.minScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    }

  }
}
