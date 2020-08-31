import 'package:flutter/material.dart';
import '../config/palette.dart';


class DoubledList extends StatelessWidget {

  final List<DoubledListItem> children;

  const DoubledList({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Wrap(
          children: this.children,
        ),
      ),
    );
  }
}



class DoubledListItem extends StatelessWidget{
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final Function onPressed;
  final bool isCentered, noSymbol;

  DoubledListItem({
    @required this.title,
    @required  this.icon,
    @required this.iconBackgroundColor,
    @required this.iconColor,
    @required this.onPressed,
    this.isCentered = false,
    this.noSymbol = false
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Palette.lightBlack,
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 50.0,
      width: MediaQuery.of(context).size.width / 2 - 30.0,
      child: RawMaterialButton(
        onPressed: this.onPressed,
        child: Row(
          children: [
            !noSymbol ? Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
                color: this.iconBackgroundColor.withAlpha(200),
              ),
              child: Icon(this.icon,color: this.iconColor,),
            ) : SizedBox.shrink(),
            Expanded(
              child: Container(
                height: 50.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: !isCentered ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        this.title,
                        style: Theme.of(context).textTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}
