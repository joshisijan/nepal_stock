import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/reuseables/offline_status.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    if(Theme.of(context).brightness == Brightness.light){
      isDark = false;
    }else{
      isDark = true;
    }
    return Scaffold(
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).canvasColor,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 32.0,
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Share Napal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Theme.of(context).textTheme.subtitle1.color,),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text('Dark Theme'),
                    trailing: Switch(
                      value: isDark,
                      activeColor: Theme.of(context).accentColor,
                      onChanged: (value){
                        setState(() {
                          if(value){
                            DynamicTheme.of(context).setBrightness(Brightness.dark);
                          }else{
                            DynamicTheme.of(context).setBrightness(Brightness.light);
                            if(MediaQuery.of(context).platformBrightness == Brightness.dark){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return ConfirmAlert(
                                      showNo: false,
                                      onYes: (){
                                        Navigator.of(context).pop();
                                      },
                                      title: 'Theme',
                                      content: 'Dark Mode is on on your Mobile Phone. To turn off Dark Mode in this app turn off Dark Mode in you Phone. \n\nNote: You can selectively turn on dark mode for this app.',
                                    );
                                  }
                              );
                            }
                          }
                        });
                      },
                    ),
                  ),
                  //for offline status
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: OfflineStatus(),
            ),
          ],
        ));
  }
}
