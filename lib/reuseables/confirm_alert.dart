import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';

class ConfirmAlert extends StatelessWidget {
  final String title;
  final String content;
  final bool haveMoreContent;
  final Widget moreContent;
  final Function onYes;
  final bool showNo;
  final Function onCancel;

  const ConfirmAlert({
    Key key,
    this.title,
    this.content,
    @required this.onYes,
    this.showNo = true,
    this.haveMoreContent = false,
    this.moreContent,
    this.onCancel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).canvasColor : kColorBlack2,
      content: haveMoreContent ? this.moreContent : Text(content, style: TextStyle(color: Theme.of(context).textTheme.subtitle1.color),),
      actions: [
        IconButton(
          icon: Icon(
            Icons.check,
            color: kColorGreen,
          ),
          onPressed: onYes,
        ),
        showNo
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150),
                ),
                onPressed: () {
                  if(this.onCancel != null){
                    this.onCancel.call();
                  }
                  Navigator.of(context).pop();
                },
              )
            : SizedBox.shrink(),
      ],
      titleTextStyle: Theme.of(context).textTheme.bodyText1,
      contentTextStyle: Theme.of(context).textTheme.caption,
    );
  }
}
