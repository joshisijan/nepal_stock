import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';

class ConfirmAlert extends StatelessWidget {
  final String title;
  final String content;
  final Function onYes;
  final bool showNo;

  const ConfirmAlert({Key key,@required this.title, @required this.content, @required this.onYes, this.showNo = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      backgroundColor: kColorBlack2,
      content: Text(content),
      actions: [
        IconButton(
          icon: Icon(Icons.check, color: kColorGreen,),
          onPressed: onYes,
        ),
        showNo ? IconButton(
          icon: Icon(Icons.close, color: kColorRed.withAlpha(150),),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ) : SizedBox.shrink(),
      ],
      titleTextStyle: Theme.of(context).textTheme.bodyText1,
      contentTextStyle: Theme.of(context).textTheme.caption,
    );
  }
}
