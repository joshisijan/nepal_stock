import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';

class AddButton extends StatelessWidget {
  final Alignment alignment;
  final Function onPressed;
  final bool loading;

  const AddButton({
    Key key,
    this.alignment = Alignment.center,
    this.loading = false,
    @required  this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: 100.0,
        child: MaterialButton(
          splashColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).textTheme.subtitle1.color.withAlpha(150) :Theme.of(context).accentColor.withAlpha(150),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).textTheme.subtitle1.color :Theme.of(context).accentColor,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !loading ? Icon(
                Icons.add,
                color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).textTheme.subtitle1.color :Theme.of(context).accentColor,
                size: 20.0,
              ) :
              Container(width: 12.0, height: 12.0,child: CircularProgressIndicator(strokeWidth: 2.0,valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).brightness == Brightness.light ? Theme.of(context).textTheme.subtitle1.color :Theme.of(context).accentColor),)),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'ADD',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).textTheme.subtitle1.color :Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
